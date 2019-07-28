import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui_framework/ui/intimate/intimate_court.dart';
import 'package:flutter_ui_framework/ui/home/home_widget.dart';
import 'package:flutter_ui_framework/ui/class_managment/Schedule.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final List<ListItem> listData = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      listData.add(new ListItem("学霸区", new IconData(0xe613,fontFamily: "PIcons",),Color(0xFF43CD80)));
      listData.add(new ListItem("吐槽池", new IconData(0xe658,fontFamily: "PIcons"),Color(0xFFFFA500)));
      listData.add(new ListItem("看课表", new IconData(0xe649,fontFamily: "PIcons"),Colors.cyan));
      listData.add(new ListItem("知心苑", new IconData(0xe50d,fontFamily: "PIcons"),Colors.yellow));
      listData.add(new ListItem("爱之城", new IconData(0xec55,fontFamily: "PIcons"),Color(0xFF1874CD)));
      listData.add(new ListItem("高校村", new IconData(0xe615,fontFamily: "PIcons"),Color(0xFFFF82AB)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("校园服务"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(top: 0),
            width: MediaQuery.of(context).size.width,
            height: 180.0,
            child: firstSwiperView(),
          ),
          Container(
            height: 10,
          ),
          Container(
            height: 300,
            padding: EdgeInsets.only(left: 13,right: 25,top: 13),
            child:new GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return new ListItemWidget(listData[index]);
              },
              itemCount: 6,
            ),
          ),
          //new Rank(),
        ],
      )
    );
  }
  Widget firstSwiperView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Swiper(
        itemCount: 4,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54,
                activeColor: Colors.white
            )
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index'),
      ),
    );
  }
  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://pic40.nipic.com/20140412/18428321_144447597175_2.jpg",
      fit: BoxFit.fill,
    ));
  }
}

class ListItem {
  final String title;
  final IconData iconData;
  final Color icon_color;
  ListItem(this.title, this.iconData,this.icon_color);
}

class ListItemWidget extends StatelessWidget {
  final ListItem listItem;
  ListItemWidget(this.listItem);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        //color: Colors.blue,
        child:new Column(
        children:<Widget>[
        new CircleAvatar(
          radius: 32.0,
          backgroundColor: listItem.icon_color,
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(listItem.iconData, size: 35.0,color: Colors.white,),
            Container(
              height: 10,
            ),
          ],
        ),
        ),
        Container(
          height: 8,
        ),
        new Text(listItem.title,style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black)),
        ])
      ),
      onTap: () {
        switch(listItem.title)
        {
          case "知心苑":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context)
                      {
                        return intimate_court();
                      }
                  )
              );
            break;
          case "看课表":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context)
                    {
                      return course_management();
                    }
                )
            );
            break;
        }
      },
    );
  }
}
