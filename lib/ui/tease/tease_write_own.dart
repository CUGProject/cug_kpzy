import 'package:flutter/material.dart';
import './tease_data_structure.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui_framework/api/write_tease_own_http_get_API.dart';
import  'package:flutter_ui_framework/utils/tap_widget_event.dart';
import 'package:flutter_ui_framework/utils/ImageVidwoView.dart';
import  'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_framework/ui/tease/tease_filter.dart';
import 'package:flutter_ui_framework/ui/tease/show_one_tease.dart';
import 'package:flutter_ui_framework/ui/tease/tease_data_structure.dart';
import 'package:flutter_ui_framework/data_structure/tease_comment_ds.dart';


/*
author:李静涛
该文件对应界面吐槽池主界面
 */

void main()
{
  runApp(new MaterialApp(home:Board()));
}

TextEditingController _userNameController = new TextEditingController();
class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Board();
  }
}

//因为ListItemWidget
Widget getBoardFirstLine(Tease_ds tease,BuildContext context)  //显示滚动屏第一行，包头像，用户名，学院，种类
{
  String show_time;
  if(tease.time.split('_').length >= 3)
    show_time = tease.time.split('_')[0] + '-' + tease.time.split('_')[1] + '-' + tease.time.split('_')[2];
  else
    show_time = tease.time;
  return Container(
      height: MediaQuery.of(context).size.height/16,
      //decoration: BoxDecoration(color: Colors.blue),
      child:Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/50,),
          GestureDetector(
            child: Container(width: MediaQuery.of(context).size.width/9,
              height: MediaQuery.of(context).size.height/17,
              //decoration:BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(10)),image: new DecorationImage(image: new NetworkImage(tease.headUrl,scale: 0.3),)),
              child: new CircleAvatar(//绘制圆头像
                radius: 36,
                backgroundImage: new NetworkImage(
                    tease.headUrl,scale: 0.5),),
            ),
            onTap: (){print("个人中心公布栏点击");},
          ),
          Container(width: MediaQuery.of(context).size.width/50,),
          GestureDetector(
            child: Container(
              child: Center(child: Text(tease.user+"---"+tease.userCollege+"\n"+show_time,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),),
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



class _Board extends State<Board> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  initState() {
    super.initState();
    print("1");
    _getInfo(0);
    //_getGreatTease();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        if(!isPerformingRequest)
          {
            setState(() {
              isPerformingRequest = true;
              //scroll_tease.add(_buildProgressIndicator());
              //print("after add ProgressIndicator,scroll tease length: "+ scroll_tease.length.toString());
            });
            _getInfo(1);
          }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  //initState调用，在build之前将服务器获取的吐槽加载进scroll_tease显示
  _getInfo(int mark)
  {
    /*
    上拉加载更多和下拉刷新调用的请求函数
    param@mark 0代表下拉刷新，1代表上拉加载
     */
    API.getTease().then((response)
    {
      print(response.body.toString());
      print("before scroll_tease_length: " + scroll_tease.length.toString());
      Map list =  json.decode(response.body);
      //print(list["tucao_module_list"]);
      int tease_number = list["tucao_number"];
      List<Tease_ds> temp_teases = [];
      for(int i = 0;i < tease_number;i++)
      {
        Tease tease =  new Tease.fromJson(list["tucao_module_list"][i]);
        print("new tease--------------");
        //print(tease.commentNum );
        Tease_ds tease_ds = new Tease_ds(headUrl:tease.headUrl,user:tease.user,userCollege:tease.userCollege,widget_mark:tease.widget_mark,widget_set_2: tease.widget_set_2,
            kind:tease.kind,time:tease.time,content_title:tease.content_title,great_comment:tease.great_comment,upItNum: tease.upItNum,commentNum: tease.commentNum,
            widget_set2: tease.widget_set);
        print(tease_ds);
        if(mark == 0)
          scroll_tease.insert(0, tease_ds);
        else
          temp_teases.add(tease_ds);
      }
      if(mark == 0)
        setState(() {
          print("after scroll_tease_length: " + scroll_tease.length.toString());
          print("下拉刷新-----------------------------------------------");
        });
      else
        {
          if(temp_teases.length == 0)
            {
              double edge = 50.0;
              double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
              if (offsetFromBottom < edge) {
                _scrollController.animateTo(
                    _scrollController.offset - (edge -offsetFromBottom),
                    duration: new Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              }
            }
          setState(() {
            //scroll_tease.removeLast();
            scroll_tease = scroll_tease + temp_teases;
            isPerformingRequest = false;
            print("上拉加载更多-------------------------------------------");
          });
        }
    });
  }

  _getGreatTease() async
  {
    great_tease.clear();
    /*
    接受后端数据，仿照getInfo，讲吐槽add到great_tease里面
     */
    http.post("http://www.cugkpzy.com/show_some_best_tucaos").then(
        (response){
          print("获取到数据！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
          Map<String,dynamic> req_map = {};
          req_map = jsonDecode(response.body);
          for(int i=0;i<4;i++)
          {
            Tease tease = new Tease.fromJson(req_map["tucao_module_list"][i]);
            print("第"+i.toString()+"个数据："+tease.toString());
            great_tease.add(Tease_ds(headUrl:tease.headUrl,user:tease.user,userCollege:tease.userCollege,widget_mark: tease.widget_mark,
                kind:tease.kind,time:tease.time,content_title:tease.content_title,great_comment:tease.great_comment,upItNum: tease.upItNum,commentNum: tease.commentNum,
                widget_set2: tease.widget_set));
          }
          print("接受完毕");
          setState(() {

          });
        }
    );
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
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return Tease_filter();
                        }
                    ));

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
                      Icons.filter,
                      color: Colors.black45,
                      size: 14.0
                  ),
                  label: new Text(
                    "筛选",
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
                          return ImageVideoView(tease.widget_set,0);
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
      child: getBoardMainContent(great_tease[index], context),
    );
  }
  List<Widget> all_page_set = [];//List里面放的是所有吐槽滚动屏片段
  Future<Null> _handleRefresh() async {//下拉刷新回调函数
    await Future.delayed(Duration(seconds: 1), () {
      _getInfo(0);
    });
  }

  get_tease_detail() async
  {
    http.post("http://www.cugkpzy.com/show_tucao_module_xiangqing/2019_08_21_01_04_06").then((req){
      Map<String,dynamic> reqmap = json.decode(req.body);
      Tease_ds tease = Tease_ds(
          headUrl: reqmap['tease']['headUrl'],
          user: reqmap['tease']['user'],
          userCollege: reqmap['tease']['userCollege'],
          kind:reqmap['tease']['kind'],
          time: reqmap['tease']['time'],
          content_title: reqmap['tease']['content_title'],
          great_comment:Map<String,String>(),
          upItNum: reqmap['tease']['upItNum'],
          commentNum: reqmap['tease']['commentNum'],
          widget_set2: List<String>.from(reqmap['tease']['widget_set'])
      );
      List<Tease_comment_ds> tease_comments = List();
      List<dynamic> temp = reqmap['tease_comments'];
      for(int i=0;i<temp.length;i++){
        //Tease_comment_ds({this.head_url,this.user_name,this.college,this.comment_text,this.reply,this.time,this.upItNum});
        tease_comments.add(Tease_comment_ds(
            head_url: temp[i]['head_url'],
            user_name: temp[i]['user_name'],
            college: temp[i]['college'],
            comment_text: temp[i]['comment_text'],
            reply: Map<String,String>.from(temp[i]['reply']),
            time: temp[i]['time'],
            upItNum: temp[i]['upItNum']
        ));
      }
      print(tease_comments);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context)
              {
                return Show_one_tease(tease: tease,tease_comments: tease_comments);;
              }
          )
      );
    });
  }

  Widget _buildProgressIndicator()
  {
    /*
    显示正在加载标志
     */
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
              opacity:isPerformingRequest ? 1.0:0.0,
              child:new CircularProgressIndicator(),
          ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print("2================================");
    all_page_set.clear();
    for(int i = 0; i < scroll_tease.length;i++)
    {
      print("real after scroll_tease length: "+ scroll_tease.length.toString());
      print(scroll_tease[0].upItNum.toString());
      all_page_set.add(
        GestureDetector(
          child: new Card(child:get_one_scroll_tease(context,scroll_tease[i]),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),),
          onTap: (){
              print("展示详情");
              get_tease_detail();
          },
        )
      );
    }
    if(isPerformingRequest)
      all_page_set.add(_buildProgressIndicator());
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
          controller: _scrollController,
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
  /*
  ===============================================下面显示单个吐槽=========================================================
   */
  Color dzColor = Colors.orange;
  TextEditingController comment_input_filed_controller;
  Widget build_one_great_comment_widget(String username,String comment,BuildContext context) //get_great_comment_widget调用的函数，显示单个评论
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
      widget.add(build_one_great_comment_widget(k, v, context));
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
    comment_input_filed_controller = _userNameController;
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right:MediaQuery.of(context).size.width/50),
      child:
      Container(//对应输入框
        //decoration: BoxDecoration(color: Colors.greenAccent),
        height: MediaQuery.of(context).size.height/5,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          maxLength: 500,//这个属性可以实现自动换行,参数含义是输入框最多输入字符个数
          maxLines: 5,//确定当前输入框高度
          controller: _userNameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
            //border: OutlineInputBorder(),
            //fillColor: Colors.grey,
            hintText: " 开始写我牛逼的评论",
            //labelText: '左上角',
            //prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
  Widget board_last_line_left(Tease_ds tease,BuildContext context,double sizeA,double sizeB) //该行用于显示滚动屏两个图标，点赞和评论
  {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: MediaQuery.of(context).size.width/30,),
              Text("评论: " + tease.commentNum.toString(),style: TextStyle(fontSize: 15,color: Colors.grey),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
              child: Icon(Icons.launch),
                onTap: (){print("转发");},
  ),
              Container(width: MediaQuery.of(context).size.width/3.7,),
              GestureDetector(
                  child: new Icon(new IconData(0xe512,fontFamily: "PIcons"),size: sizeA,color: dzColor,),
                  onTap:() async {
                    print("点赞");
                    var req = await http.post("http://www.cugkpzy.com/dian_zan/2019_08_01_21_40_13");
                    //print("tease_ds索引："+teast_index.toString());
                    print("点赞数："+req.body);
                    setState(() {
                      tease.upItNum = int.parse(req.body);
                      dzColor = Colors.red;
                    });
                  }
              ),
              Container(width: MediaQuery.of(context).size.width/80,),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(tease.upItNum.toString()),
              ),
              Container(width: MediaQuery.of(context).size.width/30,),
            ],
          )
        ],
      ),
    );
  }
  void tap_comment(String comment)async
  {
    //comment = "1233211234567";
    Map<String,String> user_info = {};
    print(comment);
    user_info.addAll({"comment_content":comment});
    var req = await http.post("http://www.cugkpzy.com/send_tucao_comment/117171/20171002196/2019_08_01_21_40_13",body:user_info);
    print(req.body);
  }
  Widget get_one_scroll_tease(BuildContext context,Tease_ds tease) {//setHeight(context);
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
                              return ImageVideoView(tease.widget_set,index);
                            }
                        )
                    );},
                );
              },
              itemCount: tease.widget_set.length,
            ),
          ),
          Container(height: MediaQuery.of(context).size.height/100,),
          board_last_line_left(tease,context,25,23),
          Container(height: MediaQuery.of(context).size.height/60,),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
            alignment:Alignment.topLeft,child: Text("精彩评论:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),),
          //build_one_great_comment_widget(tease.have_great_mark_user[0], tease.have_great_mark_content[0],context)
          Container(height: MediaQuery.of(context).size.height/50*0.8,),
          get_great_comment_widget(tease,context),//显示精彩评论
          Container(height: MediaQuery.of(context).size.height/50*0.7,),
          GestureDetector(
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Color(0x3AC0C0C0),borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(" 发表我牛逼的评论",style: TextStyle(fontSize: 17,color: Colors.grey),),
              ),
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) =>
                        Container(
                          height: MediaQuery.of(context).size.height*1/4*1.2,
                          child: Column(
                            children: <Widget>[
                              get_input_widget(context,tease),
                              Container(height: MediaQuery.of(context).size.width/50,),
                              Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: MediaQuery.of(context).size.width/13,
                                decoration: BoxDecoration(color: Colors.blue),
                                child: Center(child:
                                FlatButton(onPressed: ()
                                {
                                  //发表评论
                                  String comment = _userNameController.text.toString();
                                  tap_comment(comment);
                                },
                                  child: Text("发表",style: TextStyle(fontSize: 16,color: Colors.black),),color: Colors.blue,),),
                              )
                            ],
                          ),
                        ));
              }),
          //get_input_widget(context,tease),//提供输入款
          Container(height: MediaQuery.of(context).size.width/50,),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),//底部边框
          )
        ],
      ),
    );
  }
}
