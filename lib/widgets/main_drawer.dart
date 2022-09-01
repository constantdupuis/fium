import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    final colorScheme = themeData.colorScheme;
    final headerOnPrimary = colorScheme.onPrimary;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...myDrawerHeader(themeData),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 8, right: 0, bottom: 0),
            child: Text('Select Server to connect to',
                style: TextStyle(color: colorScheme.primary, fontSize: 22)),
          ),
          ...apiServers(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

List<Widget> myDrawerHeader(ThemeData themeData) {
  return [
    Container(
      color: themeData.colorScheme.primary,
      //height: 80,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 8,
          right: 0,
        ),
        child: Text(
          'Fium',
          style: TextStyle(
            fontSize: 22,
            color: themeData.colorScheme.onPrimary,
          ),
        ),
      ),
    ),
    Container(
      color: themeData.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 18,
          left: 16,
          right: 16,
        ),
        child: InkWell(
          onTap: () {
            print('Pressed on settings');
          },
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.gear,
                color: themeData.colorScheme.onPrimary,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Settings',
                    style: TextStyle(
                      //fontSize: 22,
                      color: themeData.colorScheme.onPrimary,
                    )),
              )
            ],
          ),
        ),
      ),
    ),
  ];
}

List<Widget> apiServers() {
  final List<int> apiServerIds = [1, 2, 3];
  return apiServerIds.map(((e) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: InkWell(
        onTap: () {
          print('Connect to server');
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.server,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Api Server #$e'),
            )
          ],
        ),
      ),
    );
  })).toList();
}
