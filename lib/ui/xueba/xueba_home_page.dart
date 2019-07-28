import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui_framework/data_structure/Xueba_tough_problem_datastrure.dart';
import 'package:flutter_ui_framework/utils/tap_widget_event.dart';
import 'Xueba_filter.dart';
/*
学霸君分为三个部分，分为排行榜，我的提问和问题会所，
这里对应的界面是问题会所
 */

class CommonThings
{
  /*
  记录例如屏幕size等常量
   */
  static Size size;
}

class XuebaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:new Xueba_page(),
    );
  }
}


class Choice
{
  const Choice({this.title});
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '排行榜'),
  const Choice(title: '我的问题'),
  const Choice(title: '问题会所'),
];


//对应问题会所界面的难题轮播Swiper
Widget BoardView(BuildContext context)
{
  return Container(
      height: MediaQuery.of(context).size.height/2.7,
      width: CommonThings.size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/5.3,
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          Swiper(
            itemCount: 3,
            itemBuilder: _swiperBuilder,
            pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Colors.blueGrey
                )
            ),
            controller: SwiperController(),
            autoplayDisableOnInteraction: true,
            scrollDirection: Axis.horizontal,
            autoplay: true,

            viewportFraction: 0.85,
            scale: 0.9,
          ),
        ],
      ),
  );
}

//根据图片组成grid布局
Widget get_pic_grid(Tough_pro_ds tough_problem,BuildContext context)
{
  return Container(
    child:new GridView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(), //MediaQuery.of(context).size.width/50所有widget标准与边框距离
      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.55),
      cacheExtent: 0,
      itemBuilder: (BuildContext context, int index2) {
        print(tough_problem.widget_set.length);
        return GestureDetector(
          child: tough_problem.widget_set[index2],  //点击开启新的页面单独显示
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context)
                    {
                      return Magnify(tough_problem.widget_set[index2]);
                    }
                )
            );},
        );
      },
      itemCount: tough_problem.widget_set.length,
    ),
  );
}

//对应SwpierBuilder部分使用，构建难题科目和已经存在时间构成的一个Row
Widget getBoardFirstLine(Tough_pro_ds tough_problem,BuildContext context)  //显示滚动屏第一行，包头像，用户名，学院，种类
{
  return Container(
      height: MediaQuery.of(context).size.height/16,
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(color: Colors.blue),
      child:Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/30.0,),
          GestureDetector(
            child: Container(width: MediaQuery.of(context).size.width/10,
              height: MediaQuery.of(context).size.height/20,
              //decoration:BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(10)),image: new DecorationImage(image: new NetworkImage(tease.headUrl,scale: 0.3),)),
              child: new CircleAvatar(//绘制圆头像
                radius: 1,
                backgroundImage: new NetworkImage(
                    tough_problem.user_url,scale: 0.2),),
            ),
            onTap: (){print("个人中心");},
          ),
          Container(width: MediaQuery.of(context).size.width/50,),
          GestureDetector(
            child: Container(
              child: Center(child: Text(tough_problem.usrname+"---"+tough_problem.college,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),),
            ),
            onTap:(){print("个人中心公布栏点击");},
          ),
          Container( width: MediaQuery.of(context).size.width/4.5,
          ),
          Container(
            child: Center(child: Text(tough_problem.subject,style: TextStyle(fontSize: 14),),),
          )
        ],
      ),
  );
}
//问题会所ListView的item的最后一行
Widget getWTHSListViewItemLastLine(Tough_pro_ds tough_problem,BuildContext context)  //显示滚动屏第一行，包头像，用户名，学院，种类
{
  return Container(
    height: MediaQuery.of(context).size.height/16,
    width: MediaQuery.of(context).size.width,
    //decoration: BoxDecoration(color: Colors.blue),
    child:Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width/50.0,),
        GestureDetector(
          child: Container(width: MediaQuery.of(context).size.width/10,
            height: MediaQuery.of(context).size.height/20,
            //decoration:BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(10)),image: new DecorationImage(image: new NetworkImage(tease.headUrl,scale: 0.3),)),
            child: new CircleAvatar(//绘制圆头像
              radius: 1,
              backgroundImage: new NetworkImage(
                  tough_problem.user_url,scale: 0.5),),
          ),
          onTap: (){print("个人中心");},
        ),
        Container(width: MediaQuery.of(context).size.width/50,),
        GestureDetector(
          child: Container(
            child: Center(child: Text(tough_problem.usrname+"---"+tough_problem.college,
              style: TextStyle(fontSize: 13),),),
          ),
          onTap:(){print("个人中心公布栏点击");},
        ),
        Container( width: MediaQuery.of(context).size.width/3.0,
        ),
        Container(
          child: Center(child: Text(tough_problem.subject,style: TextStyle(fontSize: 13),),),
        )
      ],
    ),
  );
}
//问题会所轮播图最后一行，包含关注按钮，状态文本，解答按钮
Widget getWTHSLastLine(Tough_pro_ds tough_problem,BuildContext context)
{
  return Container(
      height: MediaQuery.of(context).size.height/20,
      width: MediaQuery.of(context).size.width/1.3,
      alignment: Alignment.topRight,
      //decoration: BoxDecoration(color: Colors.blueGrey),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(onPressed: (){print("关注");},
            child: Text("关注"),
            color: Colors.cyan,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
         /*
          Container(width: MediaQuery.of(context).size.width/3.6,
          child: Container(
            alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width/4.0,
          child: FlatButton(onPressed: null,
            child: Text("查看解答"),
            color: Colors.blue,
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
          ),
          ),
          */
          FlatButton(onPressed: (){print("解答");},
            child: Text("解答"),
            color: Colors.cyan,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
        ],
      )
  );
}


Widget _swiperBuilder(BuildContext context,int index)
{
  return  Container(
      width: MediaQuery.of(context).size.width*2/3,
      height: MediaQuery.of(context).size.height/2.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        color: Colors.white,
        boxShadow: <BoxShadow>[new BoxShadow(color: Colors.grey,//阴影颜色
        blurRadius: 2.0,)],
      ),
      child: Column(
        children: <Widget>[
          getBoardFirstLine(tough_problems[index], context),
          Container(height: MediaQuery.of(context).size.width/40,),//间距
          Container(
            //tease显示的文字内容
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/30,right: MediaQuery.of(context).size.width/30,),
            alignment: Alignment.bottomLeft,
            child: Text(tough_problems[index].problem_text,style: TextStyle(fontSize: 14)),
          ),
          Container(height: MediaQuery.of(context).size.width/100,),
          get_pic_grid(tough_problems[index],context),
          getWTHSLastLine(tough_problems[index],context),
        ],
      ),
    );
}

/*
对应学霸君的排行榜部分
 */

Widget getXuebaMyQuestionPage(BuildContext context)
{
  return new RefreshIndicator(
    child:SingleChildScrollView(
      child: Column(
        children:<Widget>[

        ],
      ),
    ),
    onRefresh: (){},);
}
//对应问题会所界面
Widget getWthsPage(BuildContext context)
{
  List<Widget> listview_items = [];
  for(int i = 0; i < problems.length;i++)
  {
    listview_items.add(new Card(child:ListItemWidget(problems[i]),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),color: Colors.white,),
    );
  }

  return new RefreshIndicator(
      child:SingleChildScrollView(
        child: Column(
            children:<Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.cyan),
                height: CommonThings.size.height/15,
                child: Center(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(new IconData(0xe652,fontFamily:  "PIcons"),color: Colors.red),
                      Text("今日难题",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white,
                        shadows:<BoxShadow>[new BoxShadow(color: Colors.grey,//阴影颜色
                        blurRadius: 2.0,)]
                      ),),
                    ],
                  ) 
                ),
              ),
              //公告栏加滚动屏
              Container(
               //decoration: BoxDecoration(color: Colors.cyan),
                height: MediaQuery.of(context).size.height/2.7,//和BoardView的高度、swiperBuilder的高度一样
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height/5.3,
                      decoration: BoxDecoration(color: Colors.cyan),
                    ),
                    Card(
                      child: BoardView(context),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),color: Color(0xAAFFFFFF),
                    ),
                  ],
                ),
              ),
              Container(decoration: BoxDecoration(color: Color(0x5FCCCCCC)),
                height: MediaQuery.of(context).size.height/90*1.8,),//分割线
              Container(
                height: MediaQuery.of(context).size.height*3/50,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/50,left: MediaQuery.of(context).size.width/25),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                      //decoration: BoxDecoration(color: Colors.cyan),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      Container(
                      width: MediaQuery.of(context).size.width/3,
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.all_inclusive,color: Colors.yellow,),
                          Text(" 所有问题",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black,
                              )),
                      ]
                      )
                ),
                          GestureDetector(
                            onTap: (){print("筛选");},
                            child: Container(
                              width: MediaQuery.of(context).size.width/6,
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Icon(Icons.filter_list),
                                      Text("筛选",style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ],
                              )
                            ),
                          )
                        ],
                      ),
                  )
                ),
            ] + listview_items
        ),
      ),
    onRefresh: (){print("fresh");},
  );
}

class Xueba_page extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    // TODO: implement build
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.cyan,
              bottom: TabBar(
                  isScrollable: true,
                  tabs: choices.map((Choice choice)
                  {
                    return new Container(
                      width: CommonThings.size.width/4,
                      height:CommonThings.size.height/14,
                      //decoration: BoxDecoration(color: Colors.yellow),
                      child: new Center(child: new Text(choice.title),),
                    );
                  }).toList(),
              ),
            ),
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/11)),
        body: TabBarView(
          children:[
            getWthsPage(context),
            Text(choices[1].title),
            Text(choices[2].title),
          ]
        ),
      ),
    );
  }
}

//对应boardView下面ListItem项目
class ListItemWidget extends StatelessWidget{
  Tough_pro_ds tough_pro;
  ListItemWidget(this.tough_pro);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        physics: new NeverScrollableScrollPhysics(),
    child:GestureDetector(
      onTap: (){print("进入题目详情查看");},
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Container(height: MediaQuery.of(context).size.width/30,),//间距
            get_pic_grid(tough_pro, context),
            getWTHSListViewItemLastLine(tough_pro, context)
          ]
      ),
    )
    );
  }
}
void main() {
  runApp(XuebaPage());
}