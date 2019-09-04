import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_ui_framework/utils/tap_widget_event.dart';
import 'package:camera_utils/camera_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_framework/utils/EncodeUtils.dart';
import 'package:flutter_ui_framework/database/user_info.dart';

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
  int order = 1;
  IjkMediaController jk_controller = IjkMediaController();
  var anonymityValue = false;//是否匿名，默认false
  anonyOnCheckChange(bool isChecked) {//匿名对应开关的值变化回调函数
    setState(() {
      anonymityValue = isChecked;
    });
  }

  @override
  void dispose() {
    jk_controller?.dispose();
  }
  void showIJKDialog(url) async {
    await jk_controller.setFileDataSource(File(url));
    await jk_controller.play();
    await showDialog(
      context: context,
      builder: (_) => _buildIJKPlayer(),
    );
    jk_controller.pause();
  }
  _buildIJKPlayer() {
    return IjkPlayer(
      mediaController: jk_controller,
    );
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
    image_psths.addAll({_path:order});
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
        order += 1;
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
        order += 1;
        widget_list[widget_list.length-1] = widget;
        widget_list.add(get_more_widget(context));
        Navigator.of(context).pop();//结束后取消对话框
      });
    }
  }
  //存放视频的widget
  Widget _getVideoWidget(String _thumbPath,String path)
  {
    return ConstrainedBox(
        constraints: const BoxConstraints(
        minWidth: 150.0,
        minHeight: 100.0,
        maxWidth: 150.0,
        maxHeight: 150.0,),
    child:GestureDetector(
      child: _thumbPath != null
          ? new Opacity(
        opacity: 1.0,
        child: Stack(
          children: <Widget>[
            Center(
          child: new Image.file(
            File(
              _thumbPath,
            ),
            fit: BoxFit.fitWidth,
            //scale: 1.2,
            //fit: BoxFit.fill,
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: Center(
              child:Icon(Icons.play_circle_filled,color: Colors.white,)
          ),
        ),
          ],
        )
      )
          : new Container(),
      onTap: (){
        print("--------------------thumbPah-----------------------------------------------");
        print(path);
        showIJKDialog(path);
      },
    ),
    );
  }

  //根据isCapture选择提取录像或摄像
  Future _takeVideo(bool isCapture) async
  {
    final path = isCapture
        ? await CameraUtils.captureVideo
        : await CameraUtils.pickVideo;
    mp4_paths.addAll({path:order});
    Future<String> thumbPath = CameraUtils.getThumbnail(path);
    thumbPath.then((tpath)
    {
      setState(() {
        order += 1;
        Widget widget = _getVideoWidget(tpath,path);
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

  Map<String,int> image_psths = {};//存储图片路径
  Map<String,int> mp4_paths = {};
  TextEditingController _teaseController = new TextEditingController();//输入框的控制器
  void launchPost()
  {
    User user = new User();
    user.insert_fake_data();
    String class_name;
    String student_number;
    Future<List<Map>> userInfo = user.get_user_data();
    userInfo.then((List<Map> userInfos){
      class_name = userInfos[0]["class"];
      student_number = userInfos[0]["studentNumber"];
      print("class_name: $class_name");
      print("student_number: $student_number");
      Post(class_name, student_number);
    });
  }

  Future<void> Post(String class_name,String studentNumber) async
  {
    String url = "http://www.cugkpzy.com/send_tucao_content/$class_name/$studentNumber";
    Map<String,String> json_data = {};
    json_data.addAll({"tucao_content":_teaseController.text});
    json_data.addAll({"image_and_mp4_num":image_psths.length.toString()+mp4_paths.length.toString()});
    int i=0;
    List<String> image_paths = image_psths.keys.toList();
    List<int> image_orders = image_psths.values.toList();
    for(;i<image_paths.length;i++)
    {
      File file = File(image_paths[i]);
      print(image_paths[i]);
      String value = await EncodeUtil.image2Base64(file);
      print(image_orders[i]);
      json_data.addAll({"image_"+(image_orders[i]).toString():value});
    }
    i = 0;
    List<String> video_paths = mp4_paths.keys.toList();
    List<int> video_oders = mp4_paths.values.toList();
    for(;i<video_paths.length;i++)
    {
      File file = File(video_paths[i]);
      print(video_paths[i]);
      String value = await file.readAsBytes().then((data){
        return base64Encode(data);
      });
      print(video_oders[i]);
      json_data.addAll({"mp4_"+(video_oders[i]).toString():value});
    }
    json_data.addAll({"kind":kindValue});
    if(anonymityValue)
      json_data.addAll({"anonym":"1"});
    else json_data.addAll({"anonym":"0"});
    await http.post(url, body: json_data)
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

