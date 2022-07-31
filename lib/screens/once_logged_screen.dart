import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_users_manager/providers/auth_provider.dart';

enum eMenu { logout }

class OnceLoggedScreen extends ConsumerWidget {
  const OnceLoggedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identity Users Manager'),
        actions: [
          PopupMenuButton<eMenu>(
            onSelected: (eMenu item) {
              switch (item) {
                case eMenu.logout:
                  ref.read(authProvider).logout();
                  break;
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: eMenu.logout,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.logout,
                        color: Colors.black45,
                        size: 20,
                      ),
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('toto@toto.com'),
                  ),
                ],
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     ref.read(authProvider).logout();
          //   },
          //   icon: Icon(Icons.logout),
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You are logged in'),
            // ElevatedButton(
            //   onPressed: () {
            //     ref.read(authProvider).logout();
            //   },
            //   child: const Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}
