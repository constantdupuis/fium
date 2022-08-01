import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/providers/local_settings.dart';

import './screens/once_logged_screen.dart';
import './screens/login_screen.dart';
import './providers/auth_provider.dart';

void main() {
  LocalSettings.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var auth = ref.watch(authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: auth.isAuthentictated
          ? const OnceLoggedScreen()
          : const LoginScreen(),
    );
  }
}
