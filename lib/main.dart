import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/helpers/colors.dart';

import 'screens/api_server_form_screen.dart';
import 'providers/local_settings.dart';
import 'screens/api_server_list_screen.dart';

void main() {
  LocalSettings.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fium',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primarySwatch: createMaterialColor(const Color(0xff73214d)),
      ),
      home: const ApiServerListScreen(),
      routes: {
        ApiServerFormScreen.routeName: (context) => const ApiServerFormScreen(),
      },
    );
  }
}
