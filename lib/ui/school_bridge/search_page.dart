import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/style/global_config.dart';
/*
提供三个信息构建搜索框
recommand：搜索框里面默认的一个推荐搜索文本 String
resou_text:一系列热搜文本，List<String>
hostories:一系列搜索历史文本 List<String>
 */
void main()
{
  runApp(new MaterialApp(home:SearchPage(hostories: ["a","hkhklhkhk","hkhkhk"],
  recommand: "如何选专业",
  resou_text: ["高效对接含义","专业重要还是大学所在地重要","高考意味着最后一次不看脸的斗争",
  "高考","择校","就业"],
  )));
}

class SearchPage extends StatefulWidget{
  List<String> hostories;
  List<String> resou_text;
  String recommand;
  SearchPage({this.hostories,this.resou_text,this.recommand});
  @override
  SearchPageState createState() => new SearchPageState(hostories: hostories,resou_text: resou_text,recommand: recommand);
}

class SearchPageState extends State<SearchPage> {

  List<String> hostories;
  List<String> resou_text;
  String recommand;
  SearchPageState({this.hostories,this.resou_text,this.recommand});
  Widget get_one_resou(String text)
  {
    /*
    得到一个热搜显示框
    两个加起来最多15个字符
    一个最多21个字符
     */
    return new Container(
      height: MediaQuery.of(context).size.width/10,
      child: new Container(
        child: Center(child:new FlatButton(onPressed: (){}, child: (new Text(text,maxLines:1,style: new TextStyle(),)))),
        decoration:BoxDecoration(color: Color(0xFFCCCCCC),
        borderRadius: BorderRadius.all(Radius.circular(16)))
      ),
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      alignment: Alignment.topLeft,
    );
  }
  List<Widget> get_resou(List<String> resous)
  {
    /*
    一个List<Widget>，根据字符大小显示所有热搜框
     */
    resous.sort();
    List<Widget> resou_sets = [];
    if(resous == null)
      return null;
    for(int i = 0;i < resous.length;i++) {
      print(i);
      print(resous[i].length);
      if (21 > resous[i].length) {
        if (i + 2 < resous.length &&
            resous[i].length + resous[i + 1].length + resous[i + 2].length <
                11) {
          resou_sets.add(Row(children: <Widget>[
            get_one_resou(resous[i]),
            get_one_resou(resous[i + 1]),
            get_one_resou(resous[i + 2]),
          ]));
          i = i + 2;
        }
        else if (i + 1 < resous.length &&
            resous[i].length + resous[i + 1].length < 19) {
          resou_sets.add(Row(children: <Widget>[
            get_one_resou(resous[i]),
            get_one_resou(resous[i + 1]),
          ]));
          i++;
        }
        else {
          resou_sets.add(Row(children: <Widget>[get_one_resou(resous[i])]));
        }
      }
    }
    return resou_sets;

  }
  Widget get_history(String one_history)
  {
    /*
    得到输入历史
     */
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new Icon(Icons.access_time, color: Colors.black45, size: 16.0),
            margin: const EdgeInsets.only(right: 12.0),
          ),
          new Expanded(
            child: new Container(
              child: new Text(one_history, style: new TextStyle( color: Colors.black87, fontSize: 14.0),),
            ),
          ),
          new Container(
            child: new Icon(Icons.clear, color: Colors.black45, size: 16.0),
          )
        ],
      ),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: new BoxDecoration(
          border: new BorderDirectional(bottom: new BorderSide(color: GlobalConfig.dark == true ?  Colors.white12 : Colors.black12))
      ),
    );
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
                  hintText: recommand,
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

  @override
  Widget build(BuildContext context) {
    List<Widget> hostories_set = [];
    for(int i =0; i < this.hostories.length;i++)
      {
        hostories_set.add(get_history(this.hostories[i]));
      }
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
                  new Container(
                    child: new Text("高考圈热搜", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    margin: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  ),
                  ] + get_resou(this.resou_text) +
                  [new Container(
                    child: new Text("搜索历史", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    alignment: Alignment.topLeft,
                  )] + hostories_set,
              ),
            )
        )
    );
  }
}