import 'dart:html';
import 'dart:math';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

Widget webView(String link) => WebPlatformWebView(link: link);

class WebPlatformWebView extends StatefulWidget {
  final String link;
  const WebPlatformWebView({super.key, required this.link});

  @override
  State<WebPlatformWebView> createState() => _WebPlatformWebViewState();
}

class _WebPlatformWebViewState extends State<WebPlatformWebView> {
  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();
    ui_web.platformViewRegistry.registerViewFactory(id, (int viewId) => IFrameElement()..src = widget.link);
    return Container(child: HtmlElementView(viewType: id));
  }
}
    