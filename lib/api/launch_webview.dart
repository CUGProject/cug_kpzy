import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'launch_video_online_play.dart';

class webViewApi
{
  /*
  该类的方法用于启动各种类型的webview
   */
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  static const  kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
  webViewApi()
  {
    flutterWebViewPlugin.close();
  }
  void launchFullScreenWebView(String url)
  {
    /*
    启动一个全屏的webview
     */
    flutterWebViewPlugin.launch(url);
  }
  void launchWidgetWebview(String url,BuildContext context)
  {
    /*
    启动非全屏限制于scaffold中的webview
     */
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WidgetWebView(selectedUrl: url,)),
    );
  }

  void launchRectWebView(double left,double top,double width,double height,String url)
  {
    /*
    在界面一个矩形框里启动网页
     */
    flutterWebViewPlugin.launch(
      url,
      rect: Rect.fromLTWH(left,top,top,width),
      userAgent: kAndroidUserAgent,
      //invalidUrlRegex: r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
    );
  }
}

class WidgetWebView extends StatelessWidget
{
  /*
  webViewApi里启动非全屏时显示的界面
   */
  String selectedUrl;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  WidgetWebView({this.selectedUrl});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: selectedUrl,
      appBar: AppBar(
        title: const Text('Widget WebView'),
      ),
      withZoom: true,
      withLocalStorage: true,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    );
  }
}


class WebViewVideos extends StatelessWidget
{
  /*
  该类用于启动包含视频需要和flutter交互的webview
   */
  String article_url;
  List<String> video_urls;
  int cur_video;//记录当前点击第几个视频
  WebViewVideos({this.article_url,this.video_urls});
  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'video',
        onMessageReceived: (JavascriptMessage message) {
          cur_video = int.parse(message.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VidoPlayChewie(video_url: video_urls[cur_video],)),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebView(
      initialUrl: article_url,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        _alertJavascriptChannel(context),
      ].toSet(),
    );
  }
}