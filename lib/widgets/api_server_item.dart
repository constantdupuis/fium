import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identity_users_manager/helpers/confirm_dialog.dart';
import 'package:identity_users_manager/screens/api_server_config_home.dart';

import '../configuration/configuration.dart';
import '../helpers/info_dialog.dart';
import '../providers/local_settings.dart';
import '../screens/api_server_form_screen.dart';
import '../models/api_server.dart';

class ApiServerItem extends ConsumerWidget {
  ApiServerItem(this.apiServer, {Key? key}) : super(key: key);

  final ApiServer apiServer;
  late MediaQueryData _mediaData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _mediaData = MediaQuery.of(context);

    return Card(
      child: ListTile(
        leading: _leading(),
        title: Text(apiServer.name),
        //subtitle: Text('${apiServer.url} - ${apiServer.username}'),
        subtitle: _subtitle(apiServer),
        trailing: _trailing(context, ref, apiServer),
      ),
    );
  }

  Widget? _leading() {
    if (_mediaData.size.width <= verySmallDeviceBreakpoint) {
      return null;
    }
    return const FaIcon(
      FontAwesomeIcons.server,
    );
  }

  Widget _trailing(BuildContext context, WidgetRef ref, ApiServer apiServer) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Edit API server config',
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pushNamed(
              ApiServerFormScreen.routeName,
              arguments: ApiServerFormScreenArgs(apiServer.key),
            );
          },
        ),
        if (_mediaData.size.width > verySmallDeviceBreakpoint)
          IconButton(
            tooltip: 'Delete API server config',
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm =
                  await showConfirmDialog(context, "Delete API Server ?");
              if (confirm!) {
                final localSettings = ref.read(localSettingsProvider);
                localSettings.removeApiServer(apiServer).then((value) {
                  //print('API server removed succefully');
                }).onError((error, stackTrace) async {
                  await showInfoDialog(
                      context, "Failed to remove API [$error]");
                  //print('Failed to remove API $error');
                });
              }
            },
          ),
        IconButton(
          tooltip: 'Manage API server',
          icon: const Icon(Icons.settings),
          onPressed: () {
            //final localSettings = ref.read(localSettingsProvider);
            Navigator.of(context).pushNamed(ApiServerConfigHome.routeName,
                arguments: ApiServerConfigHomeArgs(apiServer.key));
          },
        ),
      ],
    );
  }

  Widget? _subtitle(ApiServer apiServer) {
    if (_mediaData.size.width <= verySmallDeviceBreakpoint) {
      return null;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('URL: ${apiServer.url}'),
        Text('Username: ${apiServer.username}')
      ],
    );
  }
}
