import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/style/global_config.dart';
import 'package:flutter_ui_framework/ui/school_bridge/show_scroll_question_articles.dart';
import 'package:flutter_ui_framework/data_structure/scroll_question_articles_ds.dart';

void main()
{
  runApp(MaterialApp(home: new Above_input(),));
}

//高校对接UI主界面
class Above_input extends StatefulWidget{
  @override
  State<StatefulWidget> createState()
  {
    return new _Above_input();
  }
}

class _Above_input extends State<Above_input> {

  TextEditingController _search_controller = new TextEditingController();
  Widget barSearch() {
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
                      print("跳转到搜索界面");
                    },
                    icon: new Icon(
                        Icons.search,
                        color: Colors.black45,
                        size: 16.0
                    ),
                    label: new Text(
                      "地大校园新闻",
                      style: new TextStyle(color: Colors.black45),
                    ),
                  )
              ),
              new Container(
                width: 50,
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


  @override
  Widget build(BuildContext context) {
      return  new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar:PreferredSize(
              preferredSize: Size.fromHeight(100.0),//修改appbar高度
              child: AppBar(
                title: barSearch(),
                backgroundColor: Colors.cyan,
                automaticallyImplyLeading: false, // hides leading widget
                bottom: new TabBar(
                  labelColor: Colors.black45,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.black45,
                  isScrollable: true,
                  tabs: choices.map((Choice choice) {
                    return new Tab(
                      text: choice.title,
                    );
                  }).toList(),
                ),
              ),
          ),

          body: new TabBarView(
            children: choices.map((Choice choice) {
              print("init"+choice.title);
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      );
  }
}

class Choice {
  Choice({ this.title, this.icon });
  String title;
  Widget icon;
}

List<Choice> choices =  <Choice>[
  Choice(title: '热搜榜单', icon:new Follow(articleList:articleList,)),
  Choice(title: '我要咨询', icon:new Icon(new  IconData(0xe612,fontFamily: "PIcons"),size: 128.0,)),
  Choice(title: '我要回答', icon:new Icon(new IconData(0xe608,fontFamily: "PIcons"),size: 128.0,)) ,
  Choice(title: '云游高校', icon:new Icon(new IconData(0xe673,fontFamily: "PIcons"),size: 128.0,)),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({ Key key, this.choice }) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;// reference: https://flutter.dev/docs/cookbook/design/themes
    return choice.icon;
  }
}