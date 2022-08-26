import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/models/api_server.dart';

import '../configuration/form_mode.dart';
import '../helpers/confirm_dialog.dart';
import '../helpers/info_dialog.dart';
import '../layouts/main_layouts.dart';
import '../providers/local_settings.dart';

class ApiServerFormScreenArgs {
  ApiServerFormScreenArgs(this.apiServerKey);
  final dynamic apiServerKey;
}

class ApiServerFormScreen extends ConsumerStatefulWidget {
  const ApiServerFormScreen({Key? key}) : super(key: key);

  static const routeName = '/api-server-form';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApiServerForeenState();
}

class _ApiServerForeenState extends ConsumerState<ApiServerFormScreen> {
  FormModes formMode = FormModes.edit;
  final _form = GlobalKey<FormState>();
  bool _passwordVisible = false;
  late ApiServer _apiServer;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    ApiServerFormScreenArgs? castedArgs;

    if (args == null) {
      formMode = FormModes.add;
      _apiServer = ApiServer();
    } else {
      formMode = FormModes.edit;
      castedArgs = args as ApiServerFormScreenArgs;
      final localSettings = ref.read(localSettingsProvider);
      _apiServer =
          localSettings.getApiServer(castedArgs.apiServerKey) ?? ApiServer();
    }

    return MainLayout(
      appBar: _appBar(context),
      content: _body(),
      surroundingRation: 0.2,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: formMode == FormModes.add
          ? const Text('Create API server')
          : const Text('Edit API server'),
      // actions: [
      //   if (formMode == FormModes.edit)
      //     IconButton(
      //       icon: const Icon(Icons.delete),
      //       tooltip: 'Delete',
      //       onPressed: () async {
      //         final confirm =
      //             await showConfirmDialog(context, "Delete API Server ?");
      //         if (confirm!) {
      //           final localSettings = ref.read(localSettingsProvider);
      //           localSettings.removeApiServer(_apiServer).then((value) {
      //             print('API Server removed');
      //             Navigator.of(context).pop();
      //           }).onError((error, stackTrace) async {
      //             await showInfoDialog(
      //                 context, "Failed to remove API [$error]");
      //             print('Failed to remove API $error');
      //           });
      //         }
      //       },
      //     ),
      //   IconButton(
      //     icon: const Icon(Icons.save),
      //     tooltip: formMode == FormModes.add ? 'Save' : 'Update',
      //     onPressed: () {
      //       _saveProxy();
      //     },
      //   ),
      // ],
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              initialValue: _apiServer.name,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please provide a name';
                }
                return null;
              },
              onSaved: (newValue) {
                _apiServer.name = newValue ?? _apiServer.name;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Url'),
              initialValue: _apiServer.url,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please provide an url';
                }
                return null;
              },
              onSaved: (newValue) {
                _apiServer.url = newValue ?? _apiServer.url;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              initialValue: _apiServer.username,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please provide a username';
                }
                return null;
              },
              onSaved: (newValue) {
                _apiServer.username = newValue ?? _apiServer.username;
              },
            ),
            TextFormField(
              obscureText:
                  !_passwordVisible, //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              initialValue: _apiServer.password,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please provide a password';
                }
                return null;
              },
              onSaved: (newValue) {
                _apiServer.password = newValue ?? _apiServer.password;
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _saveProxy();
                    },
                    icon: const Icon(Icons.save),
                    label: Text(formMode == FormModes.add ? 'Save' : 'Update'),
                  ),
                  if (formMode == FormModes.edit)
                    ElevatedButton.icon(
                      onPressed: () async {
                        final confirm = await showConfirmDialog(
                            context, "Delete API Server ?");
                        if (confirm!) {
                          final localSettings = ref.read(localSettingsProvider);
                          localSettings
                              .removeApiServer(_apiServer)
                              .then((value) {
                            print('API Server removed');
                            Navigator.of(context).pop();
                          }).onError((error, stackTrace) async {
                            await showInfoDialog(
                                context, "Failed to remove API [$error]");
                            print('Failed to remove API $error');
                          });
                        }
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveProxy() async {
    bool isValide = _form.currentState?.validate() ?? true;

    if (!isValide) {
      return;
    }

    _form.currentState?.save();

    if (formMode == FormModes.add) {
      _save();
    } else if (formMode == FormModes.edit) {
      _update();
    }
  }

  void _save() {
    final localSettings = ref.read(localSettingsProvider);

    // final newApiServer = ApiServer()
    //   ..name = 'Api Server ${DateTime.now().toString()}'
    //   ..url = 'https://api.server.io/v1/'
    //   ..username = 'toto@toto.com';

    localSettings.addApiServer(_apiServer).then((value) {
      print('API Serveur added with id $value');
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      print('Failed to add API Serveur');
    });
  }

  void _update() {
    final localSettings = ref.read(localSettingsProvider);
    localSettings.saveApiServer(_apiServer).then((value) {
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      print('Failed to update API Server $error');
    });
  }
}
