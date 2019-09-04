import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_ui_framework/utils/i18n/i18n.dart';

/*
单击放大显示一张图片，视频单击放大处理方式是弹出dialog，因此没有单独拿出来
 */

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

