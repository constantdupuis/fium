import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/local_settings.dart';
import '../screens/api_server_form_screen.dart';
import '../models/api_server.dart';

class ApiServerItem extends ConsumerWidget {
  const ApiServerItem(this.apiServer, {Key? key}) : super(key: key);

  final ApiServer apiServer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        // leading: const Icon(
        //   Icons.webhook,
        //   size: 36,
        // ),
        leading: const FaIcon(
          FontAwesomeIcons.server,
        ),
        title: Text(apiServer.name),
        //subtitle: Text('${apiServer.url} - ${apiServer.username}'),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('URL: ${apiServer.url}'),
            Text('Username: ${apiServer.username}')
          ],
        ),
        trailing: Row(
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
            IconButton(
              tooltip: 'Delete API server config',
              icon: const Icon(Icons.delete),
              onPressed: () {
                final localSettings = ref.read(localSettingsProvider);
                localSettings.removeApiServer(apiServer).then((value) {
                  print('API server removed succefully');
                }).onError((error, stackTrace) {
                  print('Failed to remove API $error');
                });
              },
            ),
            IconButton(
              tooltip: 'Edit API server users',
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                //final localSettings = ref.read(localSettingsProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
