import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identity_users_manager/helpers/future_return.dart';
import 'package:identity_users_manager/providers/api_server_provider.dart';

import '../layouts/main_layouts.dart';
import '../models/api_server.dart';
import '../providers/local_settings.dart';

class ApiServerConfigHomeArgs {
  ApiServerConfigHomeArgs(this.apiServerKey);
  final dynamic apiServerKey;
}

class ApiServerConfigHome extends ConsumerStatefulWidget {
  const ApiServerConfigHome({Key? key}) : super(key: key);

  static const routeName = '/api-server/config-home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApiServerConfigHomeState();
}

class _ApiServerConfigHomeState extends ConsumerState<ApiServerConfigHome> {
  late ApiServer _apiServer;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    ApiServerConfigHomeArgs? castedArgs;
    String _title = 'No name';

    if (args == null) {
      _title = 'Not Found !';
    } else {
      castedArgs = args as ApiServerConfigHomeArgs;
      final localSettings = ref.read(localSettingsProvider);
      _apiServer =
          localSettings.getApiServer(castedArgs.apiServerKey) ?? ApiServer();
      _title = '${_apiServer.name}';
    }

    final _apiServerProvider = ref.watch(apiServerProvider(_apiServer));

    final appB = AppBar(
      title: Text(_title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.personCirclePlus),
          tooltip: 'Add User',
        ),
        IconButton(
          onPressed: () {},
          //icon: const Icon(Icons.group),
          icon: const FaIcon(FontAwesomeIcons.userGroup),
          tooltip: 'Manage Roles',
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );

    return MainLayout(
      appBar: appB,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                  onPressed: () {},
                  tooltip: 'Reset search',
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: _apiServerProvider.login(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError &&
                    ((snapshot.data as FutureReturn).value) == true) {
                  return const Expanded(
                    child: Center(
                      child: Text('Logged in !'),
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: Text(
                        'Error while logging in : ${(snapshot.data as FutureReturn).message}'),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
