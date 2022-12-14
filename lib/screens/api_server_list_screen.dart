import 'package:flutter/material.dart';
import 'package:identity_users_manager/layouts/main_layouts.dart';
import 'package:identity_users_manager/screens/api_server_form_screen.dart';

import '../widgets/api_server_list.dart';

class ApiServerListScreen extends StatelessWidget {
  const ApiServerListScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appB = AppBar(
      title: const Text('Fium'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ApiServerFormScreen.routeName);
          },
          icon: const Icon(Icons.add),
          tooltip: 'Add API server config',
        ),
        SizedBox(
          width: 15,
        )
      ],
    );

    //print('AppBar height : ${appB.preferredSize.height}');

    return MainLayout(
      appBar: appB,
      content: const ApiServerList(),
    );
  }
}
