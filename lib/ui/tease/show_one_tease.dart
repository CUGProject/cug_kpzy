import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/ui/tease/tease_data_structure.dart';
import 'package:flutter_ui_framework/ui/tease/tease_write_own.dart';
import 'package:flutter_ui_framework/utils/ImageVidwoView.dart';
import 'package:flutter_ui_framework/database/user_info.dart';
import 'package:http/http.dart' as http;
import 'tease_data_structure.dart';
import 'dart:convert';
import 'package:flutter_ui_framework/data_structure/tease_comment_ds.dart';

/*
本界面主要是对于一个吐槽的全部展示，主要是展示了
全部吐槽内容（原先只是展示一部分文字），以及全部评论


 */


/*
void main()
{
  runApp(MaterialApp(home: Show_one_tease(tease: scroll_tease[0],tease_comments: [tease_comment_example],),));
}

 */
class Show_one_tease extends StatefulWidget{
  Tease_ds tease;
  List<Tease_comment_ds> tease_comments;
  Show_one_tease({this.tease,this.tease_comments});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Show_one_tease();
  }
}

class _Show_one_tease extends State<Show_one_tease>
{
  Color comment_dzColor = Colors.black54;
  Color tease_dzColor = Colors.black54;
  List<Tease_comment_ds> tease_comments2 = List();
  List<Widget> all_comments = [];//存放所有吐槽的item，作为column的children一部分
  Widget board_last_line_left(Tease_ds tease,BuildContext context,double sizeA,double sizeB)
  //该行用于显示滚动屏两个图标，点赞和评论
  {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(width: MediaQuery.of(context).size.width/4*0.95,),/*
              GestureDetector(
                child: Icon(Icons.launch),
                onTap: (){print("转发");},
              ),
              Container(width: MediaQuery.of(context).size.width/3.7,),
              GestureDetector(
                  child: Center(child: new Icon(new IconData(0xe512,fontFamily: "PIcons"),size: sizeA,color: dzColor,),),
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
              Container(width: MediaQuery.of(context).size.width/30,),*/
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget get_tease_content(BuildContext context)
  {
    fill_all_comments(context);
    return SingleChildScrollView(
      physics: new NeverScrollableScrollPhysics(),
      child:new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Container(height: MediaQuery.of(context).size.height/25,),
            getBoardFirstLine(widget.tease, context),
            Container(height: MediaQuery.of(context).size.width/30,),//间距
            Container(
              //tease显示的文字内容
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
              alignment: Alignment.bottomLeft,
              child: Text(widget.tease.content_title,style: TextStyle(fontSize: 17)),
            ),
            Container(height: MediaQuery.of(context).size.width/50,),
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
                  print(widget.tease.widget_set.length);
                  return GestureDetector(
                    child: widget.tease.widget_set[index],  //点击开启新的页面单独显示
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context)
                              {
                                return ImageVideoView(widget.tease.widget_set,index,widget.tease);
                              }
                          )
                      );},
                  );
                },
                itemCount: widget.tease.widget_set.length,
              ),
            ),
            Container(height: MediaQuery.of(context).size.width/35,),
            board_last_line_left(widget.tease,context,25,23),
          ]
      ),);
  }

  Widget get_comment_all_reply(Tease_comment_ds tease_comment)
  {
    /*
    根据评论的回复构造一个gridView显示所有回复，这里得到对应GridView
     */
    List<Widget> all_replys = [];
    tease_comment.reply.forEach((k,v){
      k = k.split('+')[0];
      all_replys.add(Row(
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width/50,),
            Container(child: Text(k,style: TextStyle(fontSize: 14,color: Colors.cyan,),)),
            Container(child: Text(" :",style: TextStyle(fontSize: 14,),)),
            Container(child: Text(v,style: TextStyle(fontSize: 14,color: Colors.black,),)),
          ],
      ));
    });
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
      decoration: BoxDecoration(color: Color(0x49C0C0C0),borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 15,
        crossAxisCount: 1,children: all_replys,),
    );
  }

  Widget get_comment_first_line(Tease_comment_ds tease_comment)
  {
   /*
   得到评论的第一行，信息有头像，姓名，学院，时间
    */
    return Container(
        height: MediaQuery.of(context).size.height/17,
        //decoration: BoxDecoration(color: Colors.blue),
        child:Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width/50,),
            GestureDetector(
              child: Container(width: MediaQuery.of(context).size.width/9,
                height: MediaQuery.of(context).size.height/15,
                //decoration:BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(10)),image: new DecorationImage(image: new NetworkImage(tease.headUrl,scale: 0.3),)),
                child: new CircleAvatar(//绘制圆头像
                  radius: 36,
                  backgroundImage: new NetworkImage(
                      tease_comment.head_url),),
              ),
              onTap: (){print("个人中心公布栏点击");},
            ),
            Container(width: MediaQuery.of(context).size.width/50,),
            GestureDetector(
              child: Container(
                child: Center(child: Text(tease_comment.user_name+"---"+tease_comment.college,style: TextStyle(fontSize: 14,
                    color: Colors.cyan),),),
              ),
              onTap:(){print("个人中心公布栏点击");},
            ),
            Container( width: MediaQuery.of(context).size.width/3.4,
            ),
            Container(
              child: Center(child: Text(tease_comment.time.split('_')[1]+'-'+tease_comment.time.split('_')[2],style: TextStyle(fontSize: 14,color: Colors.grey),),),
            )
          ],
        )
    );
  }

  Widget get_comment_lastline(BuildContext context,Tease_comment_ds tease_comment)
  {
    /*
    每个评论的最后一行，拥有点赞，评论，转发功能
     */
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.width/20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
          child: new Icon(new IconData(0xe512,fontFamily: "PIcons",),color: tease_comment.comment_dz_color,size:20 ,),
            onTap: (){
            dianZan(1,tease_comment);
            },
      ),
          Text(tease_comment.upItNum.toString(),style: TextStyle(fontSize: 12),),
          Container(width: MediaQuery.of(context).size.width/22,),
          GestureDetector(
  child: Icon(Icons.comment,size: 20,color: Colors.black54,),
  onTap: (){show_write_comment(context,0,tease_comment);},
  ),
          Container(width: MediaQuery.of(context).size.width/50,),
        ],
      ),
    );
  }

  void dianZan(int mark,Tease_comment_ds tease_comment) async
  {
    /*
    0 吐槽的点赞
    1 吐槽评论的点赞
     */
    if(mark == 0)
      {
        print("点赞");
        var req = await http.post("http://www.cugkpzy.com/dian_zan/" + widget.tease.time);
        print("点赞url:" + "http://www.cugkpzy.com/dian_zan/" + widget.tease.time);
        //print("tease_ds索引："+teast_index.toString());
        print("点赞数："+req.body);
        setState(() {
          widget.tease.upItNum = int.parse(req.body);
          tease_dzColor = Colors.orangeAccent;
        });
      }else
        {
          String tease_id = widget.tease.time;
          String comment_id = tease_comment.time;
          String url = "http://www.cugkpzy.com/dian_zan_comment/"
              "$tease_id/$comment_id";
          print("评论点赞url");
          print(url);
          var req = await http.post(url);
          setState(() {
            tease_comment.upItNum = int.parse(req.body);
            print(req.body);
            tease_comment.comment_dz_color = Colors.orangeAccent;
          });
        }
  }

  Widget get_comment_item(BuildContext context,Tease_comment_ds tease_comment)
  {
   /*
   根据一个Tease_comment_ds对象得到一个评论item
    */
    return Column(
      children: <Widget>[
        Container(height: MediaQuery.of(context).size.width/50,),
        get_comment_first_line(tease_comment),
        Container(height: MediaQuery.of(context).size.width/50,),
        Container(
          //tease显示的文字内容
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
          alignment: Alignment.bottomLeft,
          child: Text(tease_comment.comment_text,style: TextStyle(fontSize: 15)),
        ),
        Container(height: MediaQuery.of(context).size.width/50,),
        get_comment_all_reply(tease_comment),
        Container(height: MediaQuery.of(context).size.width/50,),
        get_comment_lastline(context,tease_comment),
        Container(height: MediaQuery.of(context).size.width/50,),
        Container(height: 1,decoration: BoxDecoration(color: Color(0xAAC0C0C0)),)
      ],
    );
  }

  void fill_all_comments(BuildContext context)
  {
    /*
    填充all_comments，之后作为评论展示
    这里先填充前端自定义的一些comment
     */
    all_comments.clear();
    for(int i = 0;i < widget.tease_comments.length;i++)
    {
      print(widget.tease_comments[i]);
      all_comments.add(get_comment_item(context, widget.tease_comments[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/14),//修改appbar高度
        child: AppBar(
          title: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/5),
              child: Text("吐槽详情",style: TextStyle(fontSize: 18,
              shadows:<BoxShadow>[new BoxShadow(color: Colors.black,//阴影颜色
                blurRadius: 1.0,)]),)),
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: true,
          leading: Icon(Icons.arrow_back_ios,color: Colors.white,),// hides leading widget
        ),
      ),
      body:Builder(
          builder: (BuildContext context) {
            return new RefreshIndicator(
              child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      get_tease_content(context),
                      Container(height: MediaQuery
                          .of(context)
                          .size
                          .width / 25, color: Color(0x2CC0C0C0),),
                      Container(height: MediaQuery
                          .of(context)
                          .size
                          .width / 50,),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: MediaQuery
                            .of(context)
                            .size
                            .width / 50,),
                        child: Text("评论", style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600,
                            shadows: <BoxShadow>[
                              new BoxShadow(color: Colors.indigo, //阴影颜色
                                blurRadius: 1.0,)
                            ]),),)
                    ] + all_comments
                ),
              ),
              onRefresh: _handleRefresh,
            );
          }),
      bottomNavigationBar: get_bottomAppBar(context),
    );
  }

  Future<void> _handleRefresh() async {//下拉刷新回调函数
    await Future.delayed(Duration(seconds: 1), () {
      print("下拉刷新");
      updateArea(1);
    });
  }

  Widget get_bottomAppBar(BuildContext context) {
    /*
    获得bottomAppBar的widget
     */
    return BottomAppBar(
      child: new Container(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                child: Center(
                  child: Text("发表评论", style: TextStyle(color: Colors.grey),),),
                decoration: BoxDecoration(
                    color: Color(0xAFC0C0C0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 3 * 2,
                height: 25,
              ),
              onTap: () {
                show_write_comment(context,1,null);
              },
            ),
            Container(width: MediaQuery
                .of(context)
                .size
                .width / 20,),
            GestureDetector(
    child: new Icon(new IconData(0xe512, fontFamily: "PIcons"),color: tease_dzColor,),
    onTap: (){
      dianZan(0,null);},
    ),
            Text(widget.tease.upItNum.toString(),),
            Container(width: MediaQuery
                .of(context)
                .size
                .width / 20,),
    GestureDetector(
    child: Icon(Icons.launch),
    onTap: (){print("转发");},
    ),
          ],
        ),
      ),
    );
  }

  TextEditingController _CommentController = new TextEditingController();
  String user_name;
  String class_name;
  String student_number;

  void  show_write_comment(BuildContext context,int mark,Tease_comment_ds comment)
  {
    /*
    mark 是 0 ，代表是对于评论发出评论
    mark 是 1 ，代表是对吐槽发出的评论
    可能在写功能是的参数不是很全，可以后面添加
     */
    _CommentController.clear();
    NavigatorState navigator= context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
    debugPrint("navigator is null?"+(navigator==null).toString());
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            //title: new Text("写评论"),
            content: Container(
              height: MediaQuery.of(context).size.height/5,
              child: Column(
                children: <Widget>[
                  get_input_widget(context),
                ],
              ),
            ),
            actions:<Widget>[
              new FlatButton(child:new Text("取消"), onPressed: (){
                Navigator.of(context).pop();
              },),
              new FlatButton(child:new Text("发表"), onPressed: (){
              User user = new User();
              Future<List<Map>> userInfo = user.get_user_data();
              userInfo.then((List<Map> userInfos){
                user_name = userInfos[0]["user_name"];
                class_name = userInfos[0]["class"];
                student_number = userInfos[0]["studentNumber"];
                if(mark == 1)
                  postComment(0,null);
                else
                  postComment(1,comment);
                Navigator.of(context).pop();
              });}
  ),
            ]
        ));
  }

  void  postComment(int mark,Tease_comment_ds one_comment) async
  {
    /*
    0 代表是吐槽的评论
    1 代表是吐槽评论的评论
     */
    if(mark == 0)
      {
        String tease_id = widget.tease.time;
        Map<String,String> user_info = {};
        String comment = _CommentController.text.toString();
        user_info.addAll({"comment_content":comment});
        print("http://www.cugkpzy.com/send_tucao_comment/$class_name/$student_number/$tease_id");
        var req = await http.post("http://www.cugkpzy.com/send_tucao_comment/$class_name/$student_number/$tease_id",body:user_info);
        print(req.body);
        print("评论成功");
        updateArea(0);
      }else
        {
          String tease_id = widget.tease.time;
          String comment_id = one_comment.time;
          Map<String,String> user_info = {};
          String comment = _CommentController.text.toString();
          user_info.addAll({"comment_content":comment});
          user_info.addAll({"class_name":class_name});
          user_info.addAll({"name":student_number});
          var req = await http.post("http://www.cugkpzy.com/send_tucao_comment_of_comment/$tease_id/$comment_id",body:user_info);
          print(req.body);
          print("评论成功");
          updateArea(0);
        }
  }

  Widget get_input_widget(BuildContext context)  //滚动屏的输入框
  {
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
          controller: _CommentController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
            //border: OutlineInputBorder(),
            //fillColor: Colors.grey,
            hintText: " 写评论",
            //labelText: '左上角',
            //prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }

  void updateArea(int mark) {
    /*
    0 更新评论
    1 更新全部
     */
    String tease_id = widget.tease.time;
    tease_comments2.clear();
    http.post("http://www.cugkpzy.com/show_tucao_module_xiangqing/$tease_id")
        .then((req) {
      Map<String, dynamic> reqmap = json.decode(req.body);
      Tease_ds tease = Tease_ds(
          headUrl: reqmap['tease']['headUrl'],
          user: reqmap['tease']['user'],
          userCollege: reqmap['tease']['userCollege'],
          kind: reqmap['tease']['kind'],
          time: reqmap['tease']['time'],
          widget_mark: reqmap['tease']['widget_mark'].cast<int>(),
          widget_set_2: reqmap['tease']['widget_set_2'].cast<String>(),
          content_title: reqmap['tease']['content_title'],
          great_comment: Map<String, String>(),
          upItNum: reqmap['tease']['upItNum'],
          commentNum: reqmap['tease']['commentNum'],
          widget_set2: List<String>.from(reqmap['tease']['widget_set'])
      );
      List<dynamic> temp = reqmap['tease_comments'];
      for (int i = 0; i < temp.length; i++) {
        //Tease_comment_ds({this.head_url,this.user_name,this.college,this.comment_text,this.reply,this.time,this.upItNum});
        tease_comments2.add(Tease_comment_ds(
            head_url: temp[i]['head_url'],
            user_name: temp[i]['user_name'],
            college: temp[i]['college'],
            comment_text: temp[i]['comment_text'],
            reply: Map<String, String>.from(temp[i]['reply']),
            time: temp[i]['time'],
            upItNum: temp[i]['upItNum']
        ));
      }
      setState(() {
        print("更新评论");
        print(tease_comments2);
        if(mark == 0)
          widget.tease_comments = tease_comments2;
        else
          {
            print("更新全部");
            widget.tease_comments = tease_comments2;
            widget.tease = tease;
          }
      });
    });
  }
}

