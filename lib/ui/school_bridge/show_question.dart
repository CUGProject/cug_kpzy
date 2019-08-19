import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/style/global_config.dart';
import 'package:flutter_ui_framework/data_structure/show_one_article_ds.dart';
import 'package:flutter_ui_framework/ui/school_bridge/show_one_article.dart';
/*
本界面对应的是高校对接-->提问详情

需要提供的信息是ReplyPage构造函数所有参数
本代码为了测试，将note在ReplyPageState中通过本地json文件获取，实际获取应该在ReplyPage中从后端获取

解码：
可以使用data_structure里面的show_one_article.dart,解码例子参见本代码的_loadFakeNote()函数
 */
void main()
{
  runApp(new MaterialApp(home:ReplyPage(
    title: "你认为《三体》中最牛的文明是？",
    focus_number: 4,
    reply_number: 5,
    money:5,
    user_name:"Flutter",
    state: "赏金尚未分配",
    user_url: "https://pic3.zhimg.com/v2-cd467bb9bb31d0384f065cf0bd677930_xl.jpg",
  ),
  ));
}

class Common {
  /*
  对应顶部搜索框
   */
  static Widget searchInput(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        color: Colors.white,
      ),
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
              decoration: new InputDecoration.collapsed(
                  hintText: "大家都在搜",
                  hintStyle: new TextStyle(color: Colors.grey)
              ),
            ),
          ),
          new Container(
            child: new IconButton(icon: new Icon(Icons.share, color: Colors.grey), onPressed: (){}, padding: const EdgeInsets.all(0.0), iconSize: 18.0),
          ),
          new Container(
            child: new IconButton(icon: new Icon(Icons.list, color: Colors.grey), onPressed: (){}, padding: const EdgeInsets.all(0.0), iconSize: 18.0),
          ),
        ],
      ),
      height: 36.0,
      //padding: new EdgeInsets.only(top:8.0, bottom: 8.0, left: 8.0, right: 8.0),
    );
  }
}

class ReplyPage extends StatefulWidget {
  Note note;//根据note显示文章内容，
  String title;//文章标题
  int focus_number;//关注人数
  int reply_number;//回答数目
  String user_url;//头像url
  String user_name;//用户名
  String state;//当前状态，是 赏金尚未分配还是赏金已分配
  int money;//赏金数目
  ReplyPage({this.note,this.user_url,this.title,this.focus_number,this.user_name,this.reply_number,this.state,this.money,});
  @override
  ReplyPageState createState() => new ReplyPageState();
}

class ReplyPageState extends State<ReplyPage> {

  Future<void> _loadFakeNote() async {
    var response =
    await DefaultAssetBundle.of(context).loadString("assets/test.json");
    var notes = Note.allFromResponse(response);
    //notes.sort();
    widget.note = notes[0];
    print("note is..................");
    print(widget.note);
    setState(() {
    });
  }


  @override
  void initState() {
    super.initState();
    print("------------------------");
    _loadFakeNote();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
             backgroundColor: Colors.cyan,
              title: Common.searchInput(context)
          ),
          body: new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  child: new FlatButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) {
                            return null;
                          }
                      ));
                    },
                    child: new Container(
                      child: new Text(widget.title,style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 19.0, height: 1.3, color: Colors.black)),
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                    ),
                    //color: GlobalConfig.cardBackgroundColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text("关注: " + widget.focus_number.toString(),style: TextStyle(color: Colors.black),),
                        Container(width: 4,),
                        Text("回答: " + widget.reply_number.toString(),),
                      ],),
                      Text("赏金尚未分配",style: TextStyle(color: Colors.orangeAccent),),
                      Row(
                        children: <Widget>[
                          //Icon(Icons.attach_money,color: Colors.red,),
                          Text("赏金: " + widget.money.toString() + "元",)
                        ],
                      )
                  ],
                  ),
                ),
                new Container(
                    decoration: new BoxDecoration(
                      color: Color(0x5AC0C0C0),
                        border: new Border(top: BorderSide(color: Colors.grey),bottom: BorderSide(color: Colors.grey))
                    ),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new FlatButton.icon(
                              onPressed: (){},
                              icon: new Icon(Icons.brush),
                              label: new Text("写回答"),
                              textTheme: ButtonTextTheme.accent,
                            ),
                            decoration: new BoxDecoration(
                                border: new BorderDirectional(end: new BorderSide(color: Colors.grey))
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new FlatButton(
                              onPressed: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (context) {
                                      return null;
                                    }
                                ));
                              },
                              child: new Text("全部" + widget.reply_number.toString()+"个回答 >",),
                            ),
                          ),
                        )
                      ],
                    ),
                    margin: new EdgeInsets.only(bottom: 10.0)
                ),
                new Container(
                  child: new ListTile(
                      leading: new CircleAvatar(
                          backgroundImage: new NetworkImage(widget.user_url,),
                          radius: 20.0
                      ),
                      title: new Text(widget.user_name,),
                      //subtitle: new Text("地大大四本科"),
                      //trailing: new RaisedButton.icon(color:Colors.white,onPressed: (){}, icon: new Icon(Icons.verified_user, color: Colors.grey), label: new Text("关注", style: new TextStyle(color: Colors.cyan),),)
                  ),
                  decoration: new BoxDecoration(
                      //color: GlobalConfig.cardBackgroundColor,
                      border: new BorderDirectional(bottom: new BorderSide(color: Colors.white10))
                  ),
                ),
                Container(height: 1,decoration: BoxDecoration(border: Border.all(color: Color(0xACC0C0C0))),),
                widget.note != null ? Container(
                  height: widget.note.text.length/2,
                  child: new FullPageEditorScreen(widget.note),):Container()
              ],
            ),
          ),
          bottomNavigationBar: new BottomAppBar(
              child: new Container(
                height: 50.0,
                child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new IconButton(
                                onPressed: (){ print("icon");},
                                icon: new Container(
                                  child: new Column(
                                    children: <Widget>[
                                      new Icon(Icons.star, size: 18.0, color: Colors.white,),
                                      new Text("收藏", style: new TextStyle(fontSize: 10.0, color: Colors.white),)
                                    ],
                                  ),
                                  margin: const EdgeInsets.only(),
                                  height: 32.0,
                                )
                            ),
                            new IconButton(
                                onPressed: (){ print("icon");},
                                icon: new Container(

                                  child: new Column(
                                    children: <Widget>[
                                      new Icon(Icons.mode_comment, size: 18.0, color: Colors.white,),
                                      new Text(widget.reply_number.toString(),style: new TextStyle(fontSize: 10.0, color: Colors.white),)
                                    ],
                                  ),
                                  margin: const EdgeInsets.only(),
                                  height: 30.0,
                                )
                            ),
                          ],
                ),
                color: Colors.cyan,
              )
          ),
        )
    );
  }

}