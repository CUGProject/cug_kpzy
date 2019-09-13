import 'package:flutter/material.dart';

/*
本代码针对的是打车安全出行界面
 */

void main()
{
  runApp(MaterialApp(home: new TaxiSafetyMonitor(),));
}

class Size
{
  static double height;
  static double width;
}

class TaxiSafetyMonitor extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TaxiSafetyMonitor();
  }
}

class _TaxiSafetyMonitor extends State<TaxiSafetyMonitor>
{

  Widget get_circle_part()
  {
    /*
    对应的widget是界面中间的圆形区域
     */
    return new Container(
      height: Size.height/3,
      width: Size.height/3,
      child: Column(children: <Widget>[
        Container(height:Size.width/12),
        Text("当前安全系数",style: TextStyle(color: Colors.greenAccent,fontSize: 22,fontWeight: FontWeight.w400),),
        Container(height:Size.width/40),
        Container(child: Text("0",style: TextStyle(color: Colors.lightBlue,fontSize: 80,fontWeight: FontWeight.w500),),),
        Container(height:Size.width/50),
        Text("分析结果基于大数据",style: TextStyle(color: Colors.greenAccent,fontSize: 12,fontWeight: FontWeight.w400),),
      ],),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.greenAccent,width: 2)
      ),
    );
  }

  Widget getPositionShowWidget(double longitude,double latitude)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
          Text("经度：" + longitude.toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 22,fontWeight: FontWeight.w400),),
          Text("纬度：" + latitude.toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 22,fontWeight: FontWeight.w400),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size.width = MediaQuery.of(context).size.width;
    Size.height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(child: Text("出行监测",style: TextStyle(fontSize: 21,color: Colors.white,
            shadows:<BoxShadow>[new BoxShadow(color: Colors.black,//阴影颜色
              blurRadius: 2.0,)] ),),)),
      body: Column(
        children: <Widget>[
          Container(height: Size.width/10,),
          get_circle_part(),
          Container(height: Size.width/10,),
          getPositionShowWidget(30, 50),
        ],
      ),
    );
  }
}

