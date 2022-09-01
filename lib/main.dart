import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/helpers/colors.dart';
import 'package:identity_users_manager/screens/api_server_config_home.dart';
import 'package:identity_users_manager/widgets/api_server_list.dart';
import 'package:identity_users_manager/widgets/main_drawer.dart';

import 'configuration/configuration.dart';
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
        ApiServerConfigHome.routeName: (context) => const ApiServerConfigHome(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final primarySwatch = createMaterialColor(const Color(0xff73214d));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Fium',
//       theme: ThemeData(
//         //primarySwatch: Colors.blue,
//         primarySwatch: primarySwatch,
//         primaryColor: primarySwatch.shade500,
//       ),
//       home: SwitchHome(),
//     );
//   }
// }

class HomeSmallScreen extends StatelessWidget {
  const HomeSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fium'),
        ),
        drawer: const MainDrawer(),
        body: const Center(
          child: Text('No api server selected, select one in drawer'),
        ));
  }
}

class HomeBigScreen extends StatelessWidget {
  const HomeBigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fium'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: const ApiServerList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green,
              child: Text('API Server User management'),
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchHome extends StatelessWidget {
  const SwitchHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width >= mediumDeviceBreakpoint) {
      return HomeBigScreen();
    }
    return HomeSmallScreen();
  }
}
