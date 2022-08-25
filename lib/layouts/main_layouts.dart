import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final AppBar appBar;
  final Widget content;

  const MainLayout({super.key, required this.appBar, required this.content});

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);

    // if (mediaData.size.width > 600) {
    //   return Container(
    //     color: Colors.white,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Column(
    //           mainAxisSize: MainAxisSize.max,

    //           children: [
    //             Container(color: Colors.red, child: Text('Caca')),
    //           ],
    //         ),
    //         SizedBox(
    //           width: 600,
    //           child: content,
    //         ),
    //         Container(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: appBar.preferredSize.height,
    //                 width: null,
    //                 child: Container(
    //                   decoration: const BoxDecoration(
    //                     color: Color(0xff73214d),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    if (mediaData.size.width > 900) {
      return Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: appBar.preferredSize.height,
                    width: null,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff73214d),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Scaffold(
                appBar: appBar,
                body: content,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: appBar.preferredSize.height,
                    width: null,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff73214d),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: content,
    );
  }
}
