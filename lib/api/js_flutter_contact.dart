import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
js和flutter通信
 */
void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  BuildContext _route_context;

  JavascriptChannel _channelCalled(BuildContext context){
    return JavascriptChannel(
      name: "video",
      onMessageReceived: (JavascriptMessage message){
        print("play video on url:"+message.message);
        //############在这里跳转
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _route_context = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("test"),),
        body: WebView(
          initialUrl: "https://xiamigame.github.io/web_test/",
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>[
            _channelCalled(context),
          ].toSet(),
        ),
      ),
    );
  }
}