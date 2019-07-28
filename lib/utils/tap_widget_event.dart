import 'package:flutter/material.dart';

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



