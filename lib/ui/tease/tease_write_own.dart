import 'package:flutter/material.dart';
import './tease_data_structure.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui_framework/api/write_tease_own_http_get_API.dart';
import  'package:flutter_ui_framework/utils/tap_widget_event.dart';
import  'dart:io';
import 'dart:convert';
/*
author:李静涛
该文件对应界面吐槽池主界面
 */
void main()
{
  runApp(new MaterialApp(home:Board()));
}

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Board();
  }
}

//因为ListItemWidget
Widget getBoardFirstLine(Tease_ds tease,BuildContext context)  //显示滚动屏第一行，包头像，用户名，学院，种类
{
  return Container(
      height: MediaQuery.of(context).size.height/16,
      //decoration: BoxDecoration(color: Colors.blue),
      child:Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/50,),
          GestureDetector(
            child: Container(width: MediaQuery.of(context).size.width/9,
              height: MediaQuery.of(context).size.height/18,
              //decoration:BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(10)),image: new DecorationImage(image: new NetworkImage(tease.headUrl,scale: 0.3),)),
              child: new CircleAvatar(//绘制圆头像
                radius: 1,
                backgroundImage: new NetworkImage(
                    tease.headUrl,scale: 0.5),),
            ),
            onTap: (){print("个人中心公布栏点击");},
          ),
          Container(width: MediaQuery.of(context).size.width/50,),
          GestureDetector(
            child: Container(
              child: Center(child: Text(tease.user+"---"+tease.userCollege+"\n"+tease.time,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),),
            ),
            onTap:(){print("个人中心公布栏点击");},
          ),
          Container( width: MediaQuery.of(context).size.width/3.4,
          ),
          Container(
            child: Center(child: Text(tease.kind,style: TextStyle(fontSize: 14),),),
          )
        ],
      )
  );
}
Widget board_last_line_left(Tease_ds tease,BuildContext context,double sizeA,double sizeB) //该行用于显示滚动屏两个图标，点赞和评论
{
  return Container(
    alignment: Alignment.bottomLeft,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width/50.0,),
        GestureDetector(
          child: new Icon(new IconData(0xe512,fontFamily: "PIcons"),size: sizeA,),
          onTap:(){ print("点赞");},
        ),
        Container(width: MediaQuery.of(context).size.width/80,),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(tease.commentNum.toString()),
        ),
        Container(width: MediaQuery.of(context).size.width/30,),
        GestureDetector(
          child: new Icon(new IconData(0xe609,fontFamily: "PIcons"),size: sizeB,),
          onTap:(){ print("评论");},
        ),
        Container(width: MediaQuery.of(context).size.width/80,),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(tease.upItNum.toString()),
        ),
      ],
    ),
  );
}

class _Board extends State<Board> {
  var get_teases = new List<Tease>();
  //initState调用，在build之前将服务器获取的吐槽加载进scroll_tease显示
  _getInfo()
  {
    API.getTease().then((response)
        {
          print(response.body.toString());
          Map list =  json.decode(response.body);
          //print(list["tucao_module_list"]);
          int tease_number = list["tucao_number"];
          for(int i = 0;i < tease_number;i++)
            {
              Tease tease =  new Tease.fromJson(list["tucao_module_list"][i]);
              print("--------------");
              //print(tease.commentNum );
              Tease_ds tease_ds = new Tease_ds(headUrl:tease.headUrl,user:tease.user,userCollege:tease.userCollege,
                  kind:tease.kind,time:tease.time,content_title:tease.content_title,great_comment:tease.great_comment,upItNum: tease.upItNum,commentNum: tease.commentNum,
                  widget_set2: tease.widget_set);
              scroll_tease.add(tease_ds);
            }
          setState(() {
          });
        });
  }
  @override
  initState() {
    super.initState();
   print("1");
   _getInfo();
  }

  List<Tease_ds> great_tease = teaseList;
  Widget barSearch() {//顶部appbar的搜索框
    return new Container(
      padding: EdgeInsets.only(left: 10,right: 10,top:20),
      child:new Container(
        child: new Row(
          children: <Widget>[
            new Container(
              width: 10,
            ),
            new Container(
                alignment: Alignment.topCenter,
                child: new FlatButton.icon(
                  onPressed: (){/*
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return new SearchPage();
                        }
                    ));
                    */
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: new Text("页面跳转")));
                  },
                  icon: new Icon(
                      Icons.search,
                      color: Colors.black45,
                      size: 16.0
                  ),
                  label: new Text(
                    "一周吐槽搜索框",
                    style: new TextStyle(color: Colors.black45),
                  ),
                )
            ),
            new Container(
              width: 37,
            ),
            new Container(
              decoration: new BoxDecoration(
                  border: new BorderDirectional(
                      start: new BorderSide(color: Colors.black45, width: 1.0)
                  )
              ),
              height: 14.0,
              width: 1.0,
            ),

            new Container(
              //alignment: Alignment.center,
                padding: EdgeInsets.only(right: 10),
                child: new FlatButton.icon(
                  onPressed: (){
                    /*
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return new AskPage();
                        }
                    ));
                    */
                  },
                  icon: new Icon(
                      Icons.border_color,
                      color: Colors.black45,
                      size: 14.0
                  ),
                  label: new Text(
                    "搜索",
                    style: new TextStyle(color: Colors.black45),
                  ),
                )
            )
          ],
        ),
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: Colors.white,
        ),
        height: 38,
        padding: EdgeInsets.only(top:5,left: 7,right: 5,bottom: 5),
      ),
    );
  }

  Widget getBoardMainContent(Tease_ds tease,BuildContext context)//公告栏中显示吐槽内容的图片及文字
  {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      //decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            //right: 0,//left: 0,
            child: GestureDetector(
              child: tease.widget_set[0],
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context)
                        {
                          return Magnify(tease.widget_set[0]);
                        }
                    )
                );},
            ),
          ),
          Container(
            child: Center(
              child: Text(tease.content_title,style: TextStyle(fontSize: 18),),
            ),
          ),
          /*
          Positioned(
            top: MediaQuery.of(context).size.height/4*1.53,
            child: board_last_line_left(tease,context,35,31)
          ),
          */
        ],
      ),
    );
  }

  Widget BoardView() { //轮播card
    return Container(
      //padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height/2*0.96,
        height: MediaQuery.of(context).size.height/3,
        //decoration: BoxDecoration(color: Colors.greenAccent),
        child: Stack(
          children: <Widget>[
            Swiper(
              itemCount: 4,
              //itemWidth: MediaQuery.of(context).size.width,
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
              autoplayDisableOnInteraction: true,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              viewportFraction: 0.83,
              scale: 0.9,
              //layout: SwiperLayout.STACK,
              //onTap: (index) => print('点击了第$index'),
            ),
            Positioned(
                top: MediaQuery.of(context).size.width/20,
                left:  MediaQuery.of(context).size.width/8,
                child: Container(
                  decoration: new BoxDecoration(
                      boxShadow: <BoxShadow>[
                      ]
                  ),
                  child: Text("精彩吐槽",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white,shadows:<BoxShadow>[new BoxShadow(color: Colors.black,//阴影颜色
                    blurRadius: 2.0,)] ),),
                )
            ),
          ],
        )
    );
  }
  Widget _swiperBuilder(BuildContext context, int index) { //公告栏对应内容
    return Container(
      height: MediaQuery.of(context).size.height/4,
      width: MediaQuery.of(context).size.width,
      //decoration:BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(14.0))),
      child: getBoardMainContent(teaseList[index], context),

    );
  }

  List<Widget> all_page_set = [];//List里面放的是所有吐槽滚动屏片段
  Future<Null> _handleRefresh() async {//下拉刷新回调函数
    await Future.delayed(Duration(seconds: 5), () {
      _getInfo();
    });
  }
  @override
  Widget build(BuildContext context) {
    print("2================================");
    all_page_set.clear();
    for(int i = 0; i < scroll_tease.length;i++)
    {
      all_page_set.add(new Card(child:ListItemWidget(scroll_tease[i]),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),));
    }
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(size.height/8),//修改appbar高度
          child: AppBar(
            title: barSearch(),
            backgroundColor: Colors.cyan,
            automaticallyImplyLeading: false, // hides leading widget
          ),
        ),
        body:new RefreshIndicator(
        child:SingleChildScrollView(
          child: Column(
            children:<Widget>[//公告栏加滚动屏
              BoardView(),
              Container(decoration: BoxDecoration(border: Border(bottom: new BorderSide(color: Color(0xFACCCCCC)))),height: 1,)
            ] + all_page_set,
          ),
        ),
          onRefresh: _handleRefresh,
    ),

    );
  }
}



//滚动屏的吐槽widget
class ListItemWidget extends StatelessWidget{
  Tease_ds tease;
  Widget build_one_great_comment_widget(String username,String comment,BuildContext context)
  //get_great_comment_widget调用的函数，显示单个评论
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(username + ": ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
          Text(comment,style: TextStyle(fontSize: 15.0),maxLines: ((username.length + comment.length)/24 + 1).toInt(),),
        ],
      ),
    );
  }
  Widget get_great_comment_widget(Tease_ds tease,BuildContext context) //显示精彩评论
  {
    List<Widget> widget =[];
    tease.great_comment.forEach((k,v){
        widget.add(build_one_great_comment_widget(
        k, v,
        context));
        widget.add(Container(height: MediaQuery
      .of(context).size.height/50*0.5, ));
  }
    );
    widget.add(
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text("点击查看所有评论",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.blue),),
                onTap: null,
              )
            ],
          ),
        )
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: widget,
    );
  }
  Widget get_input_widget(BuildContext context,Tease_ds tease)  //滚动屏的输入框
  {
    TextEditingController _userNameController = new TextEditingController();
    return Container(
        height: 60,
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right:MediaQuery.of(context).size.width/50),
        child:
        TextField(
          controller: _userNameController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
            border: OutlineInputBorder(),
            fillColor: Colors.grey,
            hintText: "发表我牛逼的评论",
            //labelText: '左上角',
            //prefixIcon: Icon(Icons.person),
          ),
        )
    );
  }

  ListItemWidget(this.tease);
  @override
  Widget build(BuildContext context) {//setHeight(context);
    // TODO: implement build
    return SingleChildScrollView(
      physics: new NeverScrollableScrollPhysics(),
      child:new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          getBoardFirstLine(tease, context),
          Container(height: MediaQuery.of(context).size.width/30,),//间距
          Container(
            //tease显示的文字内容
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
            alignment: Alignment.bottomLeft,
            child: Text(tease.content_title,style: TextStyle(fontSize: 17)),
          ),
          Container(height: MediaQuery.of(context).size.width/50,),
          Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: new Text("阅读原文",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.blue),),
                    onTap: null,
                  )],
              )
          ),
         Container(height: MediaQuery.of(context).size.height/100,),
         Container(
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
            itemBuilder: (BuildContext context, int index) {
              print(tease.widget_set.length);
              return GestureDetector(
                child: tease.widget_set[index],  //点击开启新的页面单独显示
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context)
                          {
                            return Magnify(tease.widget_set[index]);
                          }
                      )
                  );},
              );
            },
            itemCount: tease.widget_set.length,
          ),
         ),
          Container(height: MediaQuery.of(context).size.height/100,),
          board_last_line_left(tease, context,25,23),
          Container(height: MediaQuery.of(context).size.height/60,),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
            alignment:Alignment.topLeft,child: Text("精彩评论:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),),
          //build_one_great_comment_widget(tease.have_great_mark_user[0], tease.have_great_mark_content[0],context)
          Container(height: MediaQuery.of(context).size.height/50*0.8,),
          get_great_comment_widget(tease,context),//显示精彩评论
          Container(height: MediaQuery.of(context).size.height/50*0.7,),
          get_input_widget(context,tease),//提供输入款
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),//底部边框
          )
        ],
      ),
    );
  }
}