import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'launch_video_online_play.dart';
import 'dart:convert';
import 'launch_webview.dart';
/*
该API用于使用webview显示文章
 */

const baseUrl = 'http://www.cugkpzy.com/show_tucao_module_2/';//请求文章所有相关json数据的url
class API {
  static Future getAll_article_info() {
    print("本次文章url------------------------------------------------------------");
    var url = baseUrl;
    print(url);
    return http.get(url);
  }
}

class All_article_info {
  String article_url;//对应文章那一页的url
  List<String> video_urls;//所有视频的url
  All_article_info(String article_url,List<String> video_urls)
  {
    this.video_urls = video_urls;
    this.article_url = article_url;
  }

  //解析json格式
  All_article_info.fromJson(Map json)
      :video_urls = json["video_urls"],
       article_url = json["arcticle_url"];

  //转成json格式
  Map toJson() {
    return {"video_urls":video_urls,"article_url":article_url
    };
  }
}

void launch_webview(String url,BuildContext context)
{
  /*
  启动不含视频的网页
   */
  webViewApi api = new webViewApi();
  api.launchFullScreenWebView(url);
}

void launch_webview_mess(String url,List<String> video_urls,BuildContext context)
{
  /*
  启动含有视频的文章网页
   */
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>WebViewVideos(video_urls: video_urls,article_url: url,)),
  );
}
void main()
{
  runApp(MaterialApp(home: Test(),));
}
class Test extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Test();
  }
}

class _Test extends State<Test>
{
  String article_url;
  List<String> video_urls;
  _getAriticleInfo()
  {
    API.getAll_article_info().then((response)
    {
      print(response.body.toString());
      Map list =  json.decode(response.body);
      article_url = list["article_url"];
      video_urls = list["video_urls"];
    });
  }
  @override
  void initState()
  {
    super.initState();
    _getAriticleInfo();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Column(
        children: <Widget>[
          FlatButton.icon(onPressed: (){
            launch_webview(article_url,context);
          },
              icon: null, label: new Text("打开网页无交互")),
          FlatButton.icon(onPressed: (){
            launch_webview_mess(article_url,video_urls,context);
          },
              icon: null, label: new Text("打开网页交互")),
        ],
      )
    );
  }
}