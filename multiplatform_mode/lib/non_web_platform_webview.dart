import 'package:flutter/material.dart';
import 'package:multiplatform_mode/app_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget webView(String link) => AppPlatform.isMobile
    ? WebView(
    javascriptMode: JavascriptMode.unrestricted,
    initialUrl: link,
    onWebViewCreated: (controller){
      controller = controller;
    },
  ) : HiperLink(link: link);

class HiperLink extends StatelessWidget {
  final String link;
  const HiperLink({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Text(link),
      ),
      onTap: (){
        launch(link);
      },
    );
  }
}
