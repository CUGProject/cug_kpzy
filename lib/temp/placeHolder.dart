import 'package:flutter/material.dart';

//临时测试bottomNavigationBar
class PlaceHolder extends StatelessWidget
{
  final Color color;
  PlaceHolder({this.color,Key key}):super(key:key);
  @override
  Widget build(BuildContext context)
  {
    return new Container(
      color: color,
    );
  }
}