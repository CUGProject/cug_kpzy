import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/ui/home/home_widget.dart';

//注意代码的模块性，不断import
void main() {
 runApp(new App());
}

class App extends StatelessWidget{
  var PrimaryColor = const Color(0xFF151026);
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title:" 校园智能生态",
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home:Home(),
    );
  }
}
