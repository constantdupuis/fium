import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/widgets/api_server_item.dart';

import '../models/api_server.dart';
import '../providers/local_settings.dart';

class ApiServerList extends ConsumerWidget {
  const ApiServerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localSettings = ref.watch(localSettingsProvider);
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return const Center(child: Text('Failedto load api server list'));
        }
        final apiServerList = snapshot.data as List<ApiServer>;
        if (apiServerList.isEmpty) {
          return const Center(child: Text('No Api server yet, add one'));
        }
        return Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final apiServer = apiServerList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: ApiServerItem(apiServer),
              );
            },
            itemCount: apiServerList.length,
          ),
        );
      },
      future: localSettings.getApiServerList(),
    );
  }
}
