import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/res/colors.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatelessWidget {
  final String _url;
  final String? title;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  WebPage(this._url, {this.title = "", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) {
          Rect _buildRect() {
            final topPadding = MediaQueryData.fromWindow(window).padding.top;
            final top = topPadding;
            var height = MediaQueryData.fromWindow(window).size.height - top;
            //height -= 56.0 + MediaQueryData.fromWindow(window).padding.bottom;
            height -= MediaQueryData.fromWindow(window).padding.bottom;
            if (height < 0.0) {
              height = 0.0;
            }
            return Rect.fromLTWH(
                0.0, top, MediaQueryData.fromWindow(window).size.width, height);
          }

          var rect = _buildRect();
          flutterWebViewPlugin.resize(rect);
          return Scaffold(
            body: Column(
              children: [
                Container(
                  height: 96,
                  padding: EdgeInsets.only(top: rect.top),
                  color: Theme.of(context).accentColor,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: YColors.color_fff,
                            )),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Center(
                              child: Text(
                                "$title",
                                style: const TextStyle(
                                  color: YColors.color_fff,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: WebviewScaffold(
                    url: _url,
                    javascriptChannels: const <JavascriptChannel>{},
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
//
// @override
// Widget build(BuildContext context) => WebviewScaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             fit: StackFit.passthrough,
//             children: [
//               Center(
//                 child: Text("$title"),
//               ),
//               IconButton(
//                   onPressed: () {
//                     Navigator.maybePop(context);
//                   },
//                   icon: const Icon(Icons.arrow_back))
//             ],
//           ),
//         ),
//       ),
//       url: _url,
//     );
}
