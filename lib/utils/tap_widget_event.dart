import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

Widget widget_common;
class Magnify extends StatefulWidget
{
  Widget widget;
  Magnify(this.widget){
    widget_common = widget;
  }
  @override
  State<StatefulWidget> createState()
  {
    return _Magnify();
  }
}
class _Magnify extends State<Magnify>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:PreferredSize(
        preferredSize: Size.fromHeight(0),//修改appbar高度
    child: AppBar(
    automaticallyImplyLeading: false, // hides leading widget
    ),
    ),
      body: new GestureDetector(
        child: ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: widget_common,
      ),
        onTap: (){
          Navigator.pop(context);
        },
    ),
    );
  }
}

class Magnify_video extends StatefulWidget{
  String _path;
  Magnify_video(this._path);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Magnify_video_State(_path);
  }
}

class Magnify_video_State extends State<Magnify_video>{
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url;
  Magnify_video_State(this.url);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(url))
    // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() { _isPlaying = isPlaying; });
        }
      })
    // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Video Demo',
      home: new Scaffold(
        body: new Center(
          child: _controller.value.initialized
          // 加载成功
              ? new Container(
            height: MediaQuery.of(context).size.height,
            //aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ) : new Container(),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _controller.value.isPlaying
              ? _controller.pause
              : _controller.play,
          child: new Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}