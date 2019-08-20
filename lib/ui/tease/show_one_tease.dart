import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/ui/tease/tease_data_structure.dart';
import 'package:flutter_ui_framework/ui/tease/tease_write_own.dart';
import 'package:flutter_ui_framework/utils/ImageVidwoView.dart';
import 'package:http/http.dart' as http;
import 'tease_data_structure.dart';
import 'package:flutter_ui_framework/data_structure/tease_comment_ds.dart';

/*
本界面主要是对于一个吐槽的全部展示，主要是展示了
全部吐槽内容（原先只是展示一部分文字），以及全部评论


 */


void main()
{
  runApp(MaterialApp(home: Show_one_tease(tease: scroll_tease[0],tease_comments: [tease_comment_example],),));
}

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
  Color dzColor = Colors.orange;
  List<Widget> all_comments = [];//存放所有吐槽的item，作为column的children一部分
  Widget board_last_line_left(Tease_ds tease,BuildContext context,double sizeA,double sizeB)
  //该行用于显示滚动屏两个图标，点赞和评论
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

  @override
  Widget get_tease_content()
  {
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
                                return ImageVideoView(widget.tease.widget_set,index);
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
                child: Center(child: Text(tease_comment_example.user_name+"---"+tease_comment_example.college,style: TextStyle(fontSize: 14,
                    color: Colors.cyan),),),
              ),
              onTap:(){print("个人中心公布栏点击");},
            ),
            Container( width: MediaQuery.of(context).size.width/3.4,
            ),
            Container(
              child: Center(child: Text(tease_comment_example.time,style: TextStyle(fontSize: 14,color: Colors.grey),),),
            )
          ],
        )
    );
  }

  Widget get_comment_lastline(Tease_comment_ds tease_comment)
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
          child: new Icon(new IconData(0xe512,fontFamily: "PIcons",),color: Colors.black54,size:20 ,),
            onTap: (){print("点赞");},
      ),
          Text(tease_comment.upItNum.toString(),style: TextStyle(fontSize: 12),),
          Container(width: MediaQuery.of(context).size.width/22,),
          GestureDetector(
  child: Icon(Icons.launch,size: 20,color: Colors.black54,),
  onTap: (){print("转发");},
  ),
          Container(width: MediaQuery.of(context).size.width/20,),
          GestureDetector(
  child: Icon(Icons.comment,size: 20,color: Colors.black54,),
  onTap: (){print("评论");},
  ),
          Container(width: MediaQuery.of(context).size.width/50,),
        ],
      ),
    );
  }

  Widget get_comment_item(Tease_comment_ds tease_comment)
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
          child: Text(tease_comment_example.comment_text,style: TextStyle(fontSize: 15)),
        ),
        Container(height: MediaQuery.of(context).size.width/50,),
        get_comment_all_reply(tease_comment),
        Container(height: MediaQuery.of(context).size.width/50,),
        get_comment_lastline(tease_comment),
        Container(height: MediaQuery.of(context).size.width/50,),
        Container(height: 1,decoration: BoxDecoration(color: Color(0xAAC0C0C0)),)
      ],
    );
  }
  void fill_all_comments()
  {
    /*
    填充all_comments，之后作为评论展示
    这里先填充前端自定义的一些comment
     */
    for(int i = 0;i < widget.tease_comments.length;i++)
      all_comments.add(get_comment_item(widget.tease_comments[i]));
  }
  @override
  Widget build(BuildContext context) {
    fill_all_comments();
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
      body:new RefreshIndicator(
        child:SingleChildScrollView(
          child: Column(
            children:<Widget>[
              get_tease_content(),
              Container(height: MediaQuery.of(context).size.width/25,color: Color(0x2CC0C0C0),),
            Container(height: MediaQuery.of(context).size.width/50,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,),
                child: Text("评论",style: TextStyle(fontSize:18,fontWeight: FontWeight.w600,
                  shadows:<BoxShadow>[new BoxShadow(color: Colors.indigo,//阴影颜色
                    blurRadius: 1.0,)]),),)
            ] + all_comments
          ),
        ),
        onRefresh: (){},
      ),
    );
  }
}

