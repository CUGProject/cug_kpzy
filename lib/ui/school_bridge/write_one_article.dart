import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:notus/convert.dart';
import 'dart:io';
import 'package:http/http.dart' as https;
/*
本代码为高校对接-->发表提问代码

需要接口提供
文章内容传递：
  通过zefyr的控制器得到delta文件，进而转成json传递给后端
用户信息传递：
  稍后定义
 */

void main() {
  runApp(new MaterialApp(home: FullPageEditorScreen(),));
}

class FullPageEditorScreen extends StatefulWidget {
  @override
  _FullPageEditorScreenState createState() => new _FullPageEditorScreenState();
}

/*
doc为测试数据
 */

final doc =
    r'[{"insert":""},{"insert":"\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

class _FullPageEditorScreenState extends State<FullPageEditorScreen> {
  final ZefyrController _controller =
  ZefyrController(NotusDocument.fromDelta(getDelta()));
  final FocusNode _focusNode = new FocusNode();
  bool _editing = true;
  final titleController = TextEditingController();
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = new ZefyrThemeData(
      cursorColor: Colors.blue,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );

    final done = _editing
        ? [new FlatButton(onPressed: _stopEditing, child: Text('提交',style: TextStyle(color: Colors.red,fontSize: 16,
        shadows:<BoxShadow>[BoxShadow(color: Colors.red,blurRadius: 1)] ),))]
        : [new FlatButton(onPressed: _startEditing, child: Text('编辑',style: TextStyle(color: Colors.red,fontSize: 16,
        shadows:<BoxShadow>[BoxShadow(color: Colors.red,blurRadius: 1)]
    )),),];
    final editor = ZefyrField(
      height: MediaQuery.of(context).size.height*2,
      controller: _controller,
      focusNode: _focusNode,
      enabled: _editing,
    );

    final form = ListView(
      children: <Widget>[
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: '标题：'),style: TextStyle(fontSize: 25),),
        Container(height: 2,),
        Container(height: 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.arrow_left),
                Text("正文",style: TextStyle(fontSize: 15,color: Colors.grey),),
                Icon(Icons.arrow_right)
              ],
            )),
        editor,
      ],
    );
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.cyan,
          brightness: Brightness.light,
          title: Icon(Icons.arrow_back_ios,color: Colors.grey,),
          actions: done,
        ),

        body: ZefyrScaffold(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: form,
          ),
        )
    );
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }
  Future<String> path_to_base64(String path)async{
    File file = File(path);
    String value = await file.readAsBytes().then((data){
      return base64Encode(data);
    });
    return value;
  }
  void Post_artical(var _delta) async {
    String find_str  = "insert⟨ ​ ⟩ + {embed: {type: image, source: file:///";
    String find_str_end = "}}";
    Map<String,dynamic> map = Map();
    map.addAll({"json_list":json.encode(_controller.document)});
    List<String> image_list_base64 = List();
    for(int i=0;i<_delta.length;i++)
    {
      String str = _delta[i].toString();
      if(str.startsWith(find_str) && str.endsWith(find_str_end))
      {
        str = str.substring(find_str.length,str.length - find_str_end.length);
        await path_to_base64(str).then((base64_data){
          image_list_base64.add(base64_data);
        });
      }
    }
    print("这就是图片list");
    print(image_list_base64.length);
    map.addAll({"image_base64_list":json.encode(image_list_base64)});
    map.addAll({"mp4_base64_list":"[]"});
    map.addAll({"gaoxiao_question_date_name": "2019_08_12_01_04_46"});
    map.addAll({"class_name": 117172.toString()});
    map.addAll({"name": 20171000718.toString()});
    print("begin to up load:"+map.toString());
    await https.post("http://192.168.1.120:5001/send_gaoxiao_question_response_content",body: map).then((res){
      print(res.body);
    });
  }
  void _showDialog() async {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Container(
          height: 250,
          child: AlertDialog(
            title: new Text("确定提交么？",style: TextStyle(fontWeight: FontWeight.bold),),
            content: new Text("当前不支持草稿保存",style: TextStyle(color: Colors.grey),),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("确定"),
                onPressed: () {
                  String title = titleController.text;//标题
                  var _delta = _controller.document.toDelta();
                  Post_artical(_delta);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
    print("document:");
    print("test postion here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(_controller.document);
    _showDialog();
  }
}
