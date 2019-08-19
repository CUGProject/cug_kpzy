import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/style//global_config.dart';
import 'package:flutter_ui_framework/data_structure/listview_article_ds.dart';


//该页是热搜榜单界面
class Follow extends StatefulWidget {

  @override
  _FollowState createState() => new _FollowState();

}

class _FollowState extends State<Follow> {

  _loadArticleList()
  {
    /*
    将后端数据加入articleList
     */

  }
  @override
  void initState()
  {
    super.initState();
    _loadArticleList();
  }
  Widget build_part(Article article,int number)
  {
   return new Center(
       child: new RaisedButton(
         onPressed:(){ Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("跳转")));},
       //disabledColor: Colors.white,
         //splashColor: Colors.pink,
         color:Colors.white,
         //highlightColor:Colors.greenAccent,

       child: new Container(
         height: 120.0,
         decoration: new BoxDecoration(
             border:new Border(
               bottom: new BorderSide(width: 1.0,color:const Color(0xff999999)),
               // color:const Color(0xff6d9eeb),
             )
         ),
         child:new  Row(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             new Expanded(
               flex: 1,
               child: new Container(
                 alignment: Alignment.topLeft,
                 padding: EdgeInsets.only(top: 8),
                 child:new Text(number.toString(),style: new TextStyle(color: Colors.red,fontSize: 18.0,fontWeight: FontWeight.w700),),
               ),
             ),
             new Expanded(
               flex: 10,
               child: new Container(
                   padding: EdgeInsets.only(top: 6,bottom: 3),
                   child:new Column(
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       new Expanded(
                           flex: 4,
                           child: new Text(article.title,style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w600),)),
                       new Expanded(
                         flex: 1,
                         //child: new Text("热度1000万",style: new TextStyle(color: Colors.black45,fontSize: 11.0),))
                         child: new Row(
                           mainAxisSize:MainAxisSize.max ,
                           children: <Widget>[
                             new Text("热度" + "1000万",style: new TextStyle(color: Colors.black45,fontSize: 11.0),),
                             new Container(
                               width: 65,
                             ),
                             new Container(
                               alignment: Alignment.centerRight,
                               child:new Text("点赞数100",style: new TextStyle(color: Colors.black45,fontSize: 11.0),),
                             ),
                           ],
                         ),),
                     ],
                   )
               ),
             ),
             new Expanded(
                 flex:5,
                 child: new Container(
                   height: 85,
                   foregroundDecoration:new BoxDecoration(
                       image: new DecorationImage(
                         image: new NetworkImage("http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"),
                         centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                       ),
                       borderRadius: const BorderRadius.all(const Radius.circular(6.0))
                   ),
                 )
             ),
           ],
         ),
       ),)
   );
  }
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(

        child: new Container(
          //margin: const EdgeInsets.only(top: 5.0),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              build_part(articleList[0],1),
              build_part(articleList[1],2),
              build_part(articleList[2],3),
              build_part(articleList[3],4),

            ],
          ),
        )
    );
  }
}