import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/temp/placeHolder.dart';
import 'package:flutter_ui_framework/home.dart';
import 'school_service.dart';
import 'package:flutter_ui_framework/ui/class_managment/Schedule.dart';
//释放_HomerState到全局
_HomeState hs = _HomeState();
//因为要根据用户点击呈现不同的navigationBar，所以继承于StatefulWidget
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState()
  {
    return hs;
  }
}
class _HomeState extends State<Home>
{
  int _CurrentIndex = 0;
  //不同BottomNavigation对应的body
   List<Widget> _childern = [
    new MyApp(),
    new course_management(),
    new PlaceHolder(color:Colors.red),
    new Above_input(),
  ];
  //用户点击事件进行index修改
  void onTabTapped(int index){
    setState(() {
      _CurrentIndex = index;
    });
  }
  //主要写了左侧滑动个人中心，整个bottomNavigationBar
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(2.0),//修改appbar高度
              child:  AppBar(
              title: Text("My Flutter App"),
          ),
        ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                decoration:new BoxDecoration(image: new DecorationImage(image:new NetworkImage("http://t2.hddhhn.com/uploads/tu/201612/98/st93.png") )),
                accountName: new Text("李静涛"),
                accountEmail: new Text("2079624548@qq.com"),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"),)
            ),
            new ListTile(leading: new Icon(Icons.refresh),title: new Text("刷新"),),
            new ListTile(leading: new Icon(Icons.help),title: new Text("帮助"),),
            new ListTile(leading: new Icon(Icons.chat),title: new Text("会话"),),
            new ListTile(leading: new Icon(Icons.settings),title: new Text("设置"),),
          ],
        ),
      ),
      body:_childern[_CurrentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white, // 背景色
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.green, // 选中的颜色
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.black45))),
        // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            currentIndex: _CurrentIndex,
            fixedColor: Colors.cyan,//选中颜色
            onTap:onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon:new Icon(new IconData(0xe687,fontFamily: "PIcons")),
                title: new Text("校园服务"),
              ),
              BottomNavigationBarItem(
                icon:new Icon(new IconData(0xe649,fontFamily: "PIcons")),
                title:new Text("课程管理"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(new IconData(0xe60b,fontFamily: "PIcons")),
                title:new Text("安全监测"),
              ),
              BottomNavigationBarItem(
                icon:new Icon(new IconData(0xe501,fontFamily: "PIcons")),
                title: new Text("高校对接"),
              ),
            ]),
      ),
    );
  }
}