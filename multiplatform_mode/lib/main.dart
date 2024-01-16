import 'package:flutter/material.dart';
import 'package:multiplatform_mode/app_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'mock_webview.dart'
  if (dart.library.io) 'non_web_platform_webview.dart'
  if (dart.library.html) 'web_platform_webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _webController = TextEditingController();

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          isLoaded ? Container(
            height: 700,
            child: webView(
              //javascriptMode: JavascriptMode.unrestricted,
              'https://${_webController.value.text}',
              //this.controller = controller,
            )
          ) : Container(),
          Positioned(
            bottom: 2,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: 75,
              width: 320,
              child: TextFormField(
                controller: _webController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'введите адрес сайта'),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: 75,
              width: 320,
              child: Text(AppPlatform.platform.name),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            isLoaded = !isLoaded;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_right_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


