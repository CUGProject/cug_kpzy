
import 'package:flutter/material.dart';
import 'package:amap_base/amap_base.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter_ui_framework/database/user_info.dart';
import 'package:http/http.dart' as http;
import 'package:easy_alert/easy_alert.dart';
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
  final _amapLocation = AMapLocation();
  var _result = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController destination_controller = new TextEditingController();
  String longitude = " ";
  String latitude = " ";
  String class_name;
  String student_number;
  //初始化定位监听
  void _initLocation() async {
    _amapLocation.init();
    final options = LocationClientOptions(
      isOnceLocation: false,
      locatingWithReGeocode: true,
    );
    if (await Permissions().requestPermission()) {
      _amapLocation.startLocate(options).listen((_) => setState(() {
        _result =
        '坐标：${_.longitude}，${_.latitude} @ ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
        print(_result);
        longitude = _.longitude.toString().substring(0,9);
        latitude = _.latitude.toString().substring(0,7);
      }));
    } else {
      setState(() {
        _result = "无定位权限";
      });
    }
  }

  void launch_post(BuildContext context)
  {
    User user = new User();
    print("begin monitor..........................");
    Future<List<Map>> userInfo = user.get_user_data();
    userInfo.then((List<Map> userInfos){
      class_name = userInfos[0]["class"];
      student_number = userInfos[0]["studentNumber"];
      print("class_name: $class_name");
      print("student_number: $student_number");
      PostBegin(class_name, student_number);
    });
  }

  void PostBegin(String class_name,String student_number)async
  {
    String url = "http://www.cugkpzy.com/route_data_upload_start";
    if(destination_controller.toString().isEmpty)
      {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('目的地为空'),
              duration: Duration(seconds: 3),
            ));
        return;
      }
    Map<String,String> json_data = {};
    json_data.addAll({"class_name":class_name});
    json_data.addAll({"name":student_number});
    json_data.addAll({"start_lng":longitude});
    json_data.addAll({"start_lat":latitude});
    json_data.addAll({"location_words":destination_controller.text.toString()});
    print("目的地:" + destination_controller.text.toString());
    await http.post(url, body: json_data)
        .then((response) {
      print("post方式->status: ${response.statusCode}");
      print("post方式->body: ${response.body}");
      destination_controller.clear();
      if(response.body == "1"){
        print("middle 测试-----------------1");
        //PostMiddle();
      }
    });
  }

  void PostMiddle()async
  {
    while(true)
      {
        String url = "http://www.cugkpzy.com/route_data_upload_middle";
        print("middle 测试-----------------2");
        Map<String,String> json_data = {};
        json_data.addAll({"class_name":class_name});
        json_data.addAll({"name":student_number});
        json_data.addAll({"now_lng":longitude});
        json_data.addAll({"now_lat":latitude});
        await http.post(url, body: json_data)
            .then((response) {
          //print("post方式->status: ${response.statusCode}");
          print("post方式->body: ${response.body}");
      });
      }
  }

  @override
  initState() {
    super.initState();
    //AMapLocationClient.setApiKey("39d5d4f31ea7f3993e7a0c2824c71ec5");
    _initLocation();
    destination_controller.clear();
  }

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
        Text("当前安全系数",style: TextStyle(color: Color(0xFF00FA9A),fontSize: 22,fontWeight: FontWeight.w400),),
        Container(height:Size.width/40),
        Container(child: Text("0",style: TextStyle(color: Colors.cyan,fontSize: 80,fontWeight: FontWeight.w500),),),
        Container(height:Size.width/50),
        Text("分析结果基于大数据",style: TextStyle(color: Color(0xFF00FA9A),fontSize: 12,fontWeight: FontWeight.w400),),
      ],),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF00FA9A),width: 2)
      ),
    );
  }

  Widget getPositionShowWidget()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("经度：" + longitude,style: TextStyle(color: Colors.cyan,fontSize: 22,fontWeight: FontWeight.w400),),
        Text("纬度：" + latitude,style: TextStyle(color: Colors.cyan,fontSize: 22,fontWeight: FontWeight.w400),),
      ],
    );
  }

  Widget get_button_widget(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      RaisedButton(
      onPressed: (){launch_post(context);},
      child: Text("开始监测",style: TextStyle(color: Colors.black45,fontSize: 16),),
      color: Colors.cyan,
      textColor: Colors.cyan,
      disabledColor: Color(0xFFC0C0C0),
      splashColor: Colors.cyan,
    ),
      ],
    );
  }
  Widget get_destination_widget()
  {
    /*
    得到输入目的地的框
     */
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(width: Size.width/10,),
        Text("目的地: ",style: TextStyle(color: Color(0xFF00FA9A),fontSize: 20),),
        Container(
          width: Size.width/2*1.1,
          child: TextField(
            maxLines: 1,
            controller: destination_controller,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size.width = MediaQuery.of(context).size.width;
    Size.height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(child: Text("出行监测",style: TextStyle(fontSize: 21,color: Colors.white,
            shadows:<BoxShadow>[new BoxShadow(color: Colors.black,//阴影颜色
              blurRadius: 2.0,)] ),),)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(height: Size.width/10,),
            get_circle_part(),
            Container(height: Size.width/10,),
            getPositionShowWidget(),
            Container(height: Size.width/10,),
            get_destination_widget(),
            Container(height: Size.width/50,),
            get_button_widget(context)
          ],
        ),
      )
    );
  }
  @override
  void dispose() {
    //注意这里关闭
    _amapLocation.stopLocate();
    super.dispose();
  }
}
