import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/style//global_config.dart';
import 'package:flutter_ui_framework/data_structure/scroll_question_articles_ds.dart';

void main()
{
  runApp(MaterialApp(home: new Search_result(articleList: articleList,search_keyword: "选专业",),));
}

//该页是搜索结果显示界面
//需要给定参数: List<Article> articleList String search_keyword
class Search_result extends StatefulWidget {
  List<Article> articleList;//包含Article数据结构的系列文章
  String search_keyword;//之前输入的搜索关键字
  Search_result({this.articleList,this.search_keyword});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Search_result();
  }
}

class _Search_result extends State<Search_result> {

  @override
  void initState()
  {
    super.initState();
  }
  Widget searchInput() {
    /*
    得到输入框
     */
    return new Container(
      height: MediaQuery.of(context).size.width/11,
      child: new Row(
        children: <Widget>[
          new Container(
            child: new FlatButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: new Icon(Icons.arrow_back, color: Colors.grey),
              label: new Text(""),
            ),
            width: 60.0,
          ),
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: new InputDecoration.collapsed(
                  hintText: widget.search_keyword,
                  hintStyle: new TextStyle(color: Colors.grey)
              ),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        color: Colors.white,
      ),
    );
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
                                new Text("评论数" + article.commentNum.toString(),style: new TextStyle(color: Colors.black45,fontSize: 11.0),),
                                new Container(
                                  width: 30,
                                ),
                                new Icon(Icons.attach_money,size: 17,),
                                new Text(article.money.toString() + "元",style: new TextStyle(color: Colors.black45,fontSize: 11.0),),
                                new Container(
                                  width: 30,
                                ),
                                new Container(
                                  alignment: Alignment.centerRight,
                                  child:new Text("点赞数" + article.agreeNum.toString(),style: new TextStyle(color: Colors.black45,fontSize: 11.0),),
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
                            image: new NetworkImage(article.headUrl),
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
    return new MaterialApp(
        //theme: GlobalConfig.themeData,
        home: new Scaffold(
        appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: searchInput(),
    ),
    body: new SingleChildScrollView(
    child: new Column(
    children: <Widget>[
              Container(height:MediaQuery.of(context).size.width/20),
              build_part(widget.articleList[0],1),
              build_part(widget.articleList[1],2),
              build_part(widget.articleList[2],3),
              build_part(widget.articleList[3],4),
            ],
          ),
        ),)
    );
  }
}