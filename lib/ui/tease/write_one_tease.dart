import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_ui_framework/utils/tap_widget_event.dart';
import 'package:camera_utils/camera_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_framework/utils/EncodeUtils.dart';

List<Widget> widget_list = [];//存放发表时选中的图片或视频
String kindValue = "学习";//存放kind选择值
bool first_turn = true;// 存放用户发表的视频或者照片时，第一次默认加一个+的widget
void main()
{
  runApp(new MaterialApp(home:writeOneTease()));
}

class writeOneTease extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _writeOneTease();
  }
}

class _writeOneTease extends State<writeOneTease>
{
  var anonymityValue = false;//是否匿名，默认false
  anonyOnCheckChange(bool isChecked) {//匿名对应开关的值变化回调函数
    setState(() {
      anonymityValue = isChecked;
    });
  }

  Widget get_more_widget(BuildContext context)//一个+的widget
  {
    return GestureDetector(
      onTap: _onClick,
      child:
      ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100.0,
          minHeight: 100.0,
          maxWidth: 150.0,
          maxHeight: 150.0,),
        child: Container(
          width: (MediaQuery.of(context).size.width*0.48 - 3)*2/3,
          height: (MediaQuery.of(context).size.width*0.48 - 3)*2/3/1.2,
          decoration: BoxDecoration(color:Color(0xFFEDEDED)),
          child: new Icon(Icons.add,size: 55,color: Colors.grey,),
        ),
      ),
    );
  }

  //通过图片路径得到图片
  Widget _getImageFromFile(String _path) {
    image_psths.add(_path);
    print("增加图片路径" + _path);
    return GestureDetector(
      child:new Image.file(
                File(
                  _path,
                ),
                fit: BoxFit.fill
              ),
      onTap: (){ Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context)
              {
                return Magnify(Image.file(
                  File(
                    _path,
                  ),
                  fit: BoxFit.fill,
                ),);
              }
          )
      );},
    );
  }
  //拍摄图片
  Future _captureImage() async {
    final path = await CameraUtils.captureImage;
    if (path != null) {
      setState(() {
        Widget widget = _getImageFromFile(path);
        widget_list[widget_list.length-1] = widget;
        widget_list.add(get_more_widget(context));
        Navigator.of(context).pop();//结束后取消对话框
      });
    }
  }
  //提取图片
  Future _pickImage() async {
    final path = await CameraUtils.pickImage;
    if (path != null) {
      setState(() {
        Widget widget = _getImageFromFile(path);
        widget_list[widget_list.length-1] = widget;
        widget_list.add(get_more_widget(context));
        Navigator.of(context).pop();//结束后取消对话框
      });
    }
  }
  //存放视频的widget
  Widget _getVideoWidget(String _thumbPath)
  {
    return _thumbPath != null
        ? new Opacity(
      opacity: 0.5,
      child: new Image.file(
        File(
          _thumbPath,
        ),
        fit: BoxFit.fitHeight,
      ),
    )
        : new Container();
  }
  //根据isCapture选择提取录像或摄像
  Future _takeVideo(bool isCapture) async
  {
    final path = isCapture
        ? await CameraUtils.captureVideo
        : await CameraUtils.pickVideo;
    Future<String> thumbPath = CameraUtils.getThumbnail(path);
    thumbPath.then((path)
    {
      setState(() {
        Widget widget = _getVideoWidget(path);
        widget_list[widget_list.length-1] = widget;
        widget_list.add(get_more_widget(context));
        Navigator.of(context).pop();//结束后取消对话框
      });
    });
  }
  _onClick()//每次用户点击后，增加一个+的widget,并弹出拍照或选取照片的选择对话框
  {
    showDialog(
        context: context,
        builder:(context)
        {
          return new SimpleDialog(
              contentPadding: const EdgeInsets.all(10.0),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text("拍照"),
                  onPressed: _captureImage,
                ),
                SimpleDialogOption(
                  child: Text("选择照片"),
                  onPressed: _pickImage,
                ),
                SimpleDialogOption(
                  child: Text("录像"),
                  onPressed: (){_takeVideo(true);}
                ),
                SimpleDialogOption(
                    child: Text("选择视频"),
                    onPressed: (){_takeVideo(false);}
                ),
              ]
          );
        });
  }

  Widget getFromWidgetList(int index,BuildContext context) //gridView的itemBuilder
  {
    return widget_list[index];
  }
  Widget getKindWidget(String _value) //对应kind选择的每一个选择
  {
    return RadioListTile<String>(
      value: _value,
      groupValue: kindValue,
      activeColor: Colors.cyan,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (value) {
        setState(() {
          kindValue = value;
        });
      },
      title: Text(_value,style: TextStyle(fontSize: 13),),
    );
  }

  List<String> image_psths = [];//存储图片路径
  TextEditingController _teaseController = new TextEditingController();//输入框的控制器
  void launchPost() async
  {
    String url = "http://www.cugkpzy.com/send_tucao_content_2/117171/20171002196";
    Map<String,String> json_data = {};
    int img_counter = 0;
    for(int i = 0;i < image_psths.length;i++)
      {
        img_counter += 1 ;
        File file = File(image_psths[i]);
        print("img_paths: " + image_psths[i]);
        String value = await EncodeUtil.image2Base64(file);
        String name = "image" + img_counter.toString();
        print("filename: " + name);
        json_data.addAll({name:value});
        String anony = "0";
        if(anonymityValue)
          anony = "1";
        json_data.addAll({"anonym":anony});
      }
      json_data.addAll({"tucao_content":_teaseController.text});
    json_data.addAll({"kind":kindValue});
    json_data.addAll({"image_num":image_psths.length.toString()});
    http.post(url, body: json_data)
        .then((response) {
      print("post方式->status: ${response.statusCode}");
      print("post方式->body: ${response.body}");
    });
  }
  @override
  Widget build(BuildContext context) {
    if(first_turn) { widget_list.add(get_more_widget(context));};
    first_turn = false;
    Widget appBarWidget(BuildContext context) {
      return Container(
        alignment: Alignment.centerRight,
        child: GestureDetector(
            onTap: null,child: Container(
          height: MediaQuery.of(context).size.height/15,
          decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.all(const Radius.circular(7))),
          child: FlatButton(onPressed: launchPost, child: Text("发表",style: TextStyle(fontSize: 17,color: Colors.white),)),//appbar右边的发表按钮
        )
        ),
      );
    };
    // TODO: implement build
    print(widget_list.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          leading: new Icon(Icons.arrow_back),elevation: 10.0,
          title: appBarWidget(context),
        ),
        body: SingleChildScrollView(
          //physics: new NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                //decoration: BoxDecoration(color: Colors.blue),
                child: Stack(
                  children: <Widget>[
                    Positioned(top:MediaQuery.of(context).size.height/25 ,
                      child: Container(//对应输入框
                        //decoration: BoxDecoration(color: Colors.greenAccent),
                        height: MediaQuery.of(context).size.height/3.1,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          maxLength: 1000,//这个属性可以实现自动换行,参数含义是输入框最多输入字符个数
                          maxLines: 5,//确定当前输入框高度
                          controller: _teaseController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
                            //border: OutlineInputBorder(),
                            //fillColor: Colors.grey,
                            hintText: " 开始写我的吐槽",
                            //labelText: '左上角',
                            //prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: 200,minWidth: 200
                ),
                child: Container(
                  // height:400,
                  width: MediaQuery.of(context).size.width,
                  height: (1+ widget_list.length/3) * MediaQuery.of(context).size.height/6.8 + 80,
                  //decoration: BoxDecoration(color: Colors.blue),
                  child: new GridView.builder(//对应用户自己选择的图片或视频
                    shrinkWrap: true,
                    physics: new NeverScrollableScrollPhysics(), //MediaQuery.of(context).size.width/50所有widget标准与边框距离
                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50,),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0,
                        childAspectRatio: 1.1),
                    cacheExtent: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return getFromWidgetList(index, context);
                    },
                    itemCount: widget_list.length,
                  ),
                ),
              ),
              new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Container(//种类选择
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/12,
                child:  Row(
                  children: <Widget>[
                    Flexible(
                        child:getKindWidget("学习")),
                    Flexible(
                        child:getKindWidget("人际")),
                    Flexible(
                        child:getKindWidget("爱情")),
                  ],
                ),
              ),
              Container(//种类选择
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/12,
                child:  Row(
                  children: <Widget>[
                    Flexible(
                        child:getKindWidget("家人")),
                    Flexible(
                        child:getKindWidget("学校")),
                    Flexible(
                        child:getKindWidget("生活")),
                  ],
                ),),
              new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/10,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50),
                  //匿名选择开关
                  child: Center(
                    child: new SwitchListTile(
                      value: anonymityValue,
                      activeColor: Colors.cyan,
                      onChanged: anonyOnCheckChange,
                      secondary: new Icon(
                          Icons.label,
                          color: Colors.cyan
                      ),
                      title: new Text("匿名发布"),
                    ),
                  )
              ),
              Container(
                height: MediaQuery.of(context).size.width/20,
              ),
              new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Container(
                height: MediaQuery.of(context).size.height/10,
              ),
            ],
          ),
        )
    );
  }
}

