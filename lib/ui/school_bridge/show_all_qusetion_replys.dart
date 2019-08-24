import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/data_structure/quesiotn_scroll_reply_ds.dart';

void main(){
  runApp(MaterialApp(home: new Show_question_replys(
  title: "你认为《三体》中最牛的文明是？",
    id: "2019-9-23-4-15",
    scroll_reply_articles: scroll_reply_articles_example,
  ),));
}
/*
本代码写的界面对应的是显示一个问题所有的回复文章界面，回复文章以滚动屏方式显示
 */
class Show_question_replys extends StatefulWidget
{
  String title;//问题标题
  String id;//问题标识符，后端实际传来的时间，
  List<Scroll_reply_ds> scroll_reply_articles;//包含Scroll_reply_ds类型的list，通过一个Scroll_reply_ds类型变量显示一篇文章的概述
  Show_question_replys({this.title,this.id,this.scroll_reply_articles});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Show_question_replys();
  }
}

class _Show_question_replys extends State<Show_question_replys>
{
  @override
  Widget build(BuildContext context) {
    List<Widget> question_reply_items = [];
    for(int i = 0;i < widget.scroll_reply_articles.length;i++)
      {
        question_reply_items.add(
            GestureDetector(
              child: new Card(child:Question_reply_item(scroll_reply_article_item: widget.scroll_reply_articles[i],),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),),
              onTap: (){
                print("展示详情");
              },
            )
        );
      }
    // TODO: implement build
    return new Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/14),//修改appbar高度
        child: AppBar(
          title: new Center(child:Text("全部回答",style: TextStyle(shadows:<BoxShadow>[new BoxShadow(color: Colors.black,//阴影颜色
            blurRadius: 2.0,)] ),)),
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: false, // hides leading widget
        ),
      ),
      body: new SingleChildScrollView(
        child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                child: new Container(
                  child: new Text(widget.title,style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 19.0, height: 1.3, color: Colors.black)),
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                ),),
              Container(height: 1,decoration: BoxDecoration(border: Border.all(color: Color(0xACC0C0C0))),),
              Container(height: MediaQuery.of(context).size.width/50,),
    ] + question_reply_items
        )));
  }
}

/*
对应一个回复的数据结构
 */
class Question_reply_item extends StatefulWidget
{
 Scroll_reply_ds scroll_reply_article_item;
 Question_reply_item({this.scroll_reply_article_item});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Question_reply_item();
  }
}

class _Question_reply_item extends State<Question_reply_item>
{
  Widget getFirstLine()
  {
    /*
    得到第一行，包括头像昵称，以及身份
     */
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
                      widget.scroll_reply_article_item.head_url,scale: 0.5),),
              ),
              onTap: (){print("个人中心公布栏点击");},
            ),
            Container(width: MediaQuery.of(context).size.width/50,),
            GestureDetector(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.scroll_reply_article_item.user_name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                    Text(widget.scroll_reply_article_item.identity,style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w600),)
                  ],
                )),
              onTap:(){print("个人中心公布栏点击");},
            ),
            Container( width: MediaQuery.of(context).size.width/8,
            ),
            Icon(Icons.verified_user,color: Colors.amberAccent,),
            Container(
              child: Center(child: Text("已认证",style: TextStyle(fontSize: 13,color:Colors.grey,fontWeight: FontWeight.w600),),),
            )
          ],
        )
    );
  }
  Widget get_last_line()
  {
    /*
    显示点赞数，评论数
     */
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Text("点赞" + widget.scroll_reply_article_item.upNum.toString(),style: TextStyle(color: Colors.grey),),
  Container(width: MediaQuery.of(context).size.width/20,),
        new Text("评论" + widget.scroll_reply_article_item.commentNum.toString(),style: TextStyle(color: Colors.grey)),
        Container(width: MediaQuery.of(context).size.width/50,)
      ],
    );
  }
  Widget get_pictures_part()
  {
    if(widget.scroll_reply_article_item.img_urls.length == 0)
      return Container(height: 1,);
    if(widget.scroll_reply_article_item.img_urls.length > 3)
      return  Container(height: 1,);
    if(widget.scroll_reply_article_item.img_urls.length == 1)
      {
        return Container(
          height: MediaQuery.of(context).size.width/4,
          decoration: BoxDecoration(
            image: new DecorationImage(
              // fit:BoxFit.fill,
                image: new NetworkImage(widget.scroll_reply_article_item.img_urls[0], )),
          ),
        );
      }
    return Container(
      child:new GridView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(), //MediaQuery.of(context).size.width/50所有widget标准与边框距离
        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.scroll_reply_article_item.img_urls.length,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.55),
        cacheExtent: 0,
        itemBuilder: (BuildContext context, int index) {
          print(widget.scroll_reply_article_item.img_urls.length);
          return Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  // fit:BoxFit.fill,
                    image: new NetworkImage(widget.scroll_reply_article_item.img_urls[index], scale: 0.8)),
              ),
            );},
        itemCount: widget.scroll_reply_article_item.img_urls.length,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        physics: new NeverScrollableScrollPhysics(),
    child:new Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:<Widget>[
      //Container(height: MediaQuery.of(context).size.width/50,),
      getFirstLine(),
      Container(height: MediaQuery.of(context).size.width/50,),
      get_pictures_part(),
      Container(height: MediaQuery.of(context).size.width/50,),
      Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/50),
        child: Text(widget.scroll_reply_article_item.head_text),
      ),
      get_last_line(),
      Container(height: MediaQuery.of(context).size.width/50,),
      //Container(height: 1,decoration: BoxDecoration(border: Border.all(color: Color(0xACC0C0C0))),),
      ]
    )
    );
  }
}