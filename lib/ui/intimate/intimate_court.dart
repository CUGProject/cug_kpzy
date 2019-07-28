import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:flutter_ui_framework/ui/intimate/intimate_swiper.dart';
import 'intimate_user_center.dart';

class account  //用户
{
  /*
  排名数据结构类
   */
  String img;//头像
  String name;//姓名
  String college;//学院
  String expert;//专业
  String user_class;//班级
  int grade;//分数
  int love_number;//点赞数
  int solved_problems;//解答的问题数目
  account({this.college,this.name,this.solved_problems,this.expert,this.user_class,this.img,this.love_number,this.grade});
}

class Problem
{
  /*
  心理问题数据结构
   */
  String img;//头像
  String name;//姓名
  String problem;//问题
  String time;//时间
  Problem({this.img,this.name,this.problem,this.time});
}

class mid_module
{
  /*
  对应大厅界面中间的部分
   */
  Widget image_widget;
  String name;
  String intro;
  String info;
  mid_module({this.image_widget,this.name,this.intro,this.info});
}

class Size
{
  /*
  屏幕尺寸，避免每次从context获取
   */
  static double height;
  static double width;
}

//主界面
class intimate_court extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return intimate_court_state();
  }
}
class intimate_court_state extends State<intimate_court>
{
  double screen_wide = 0;
  TabController mController;
  List<String> tabTitles = List();
  List<Widget> tabBarViewChildren = List();
  //----列表
  List<account> topList = List();   //排行榜列表
  List<mid_module> modules = [];//中间四个模块部分
  //List<int> topScore = List();   //排行榜分数
  Widget getModulesPart()
  {
    /*
    对应大厅界面中间的同学美文、男生世界、女生世界
     */
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),//这个属性
        crossAxisCount: 3,
        shrinkWrap: true,//这个属性
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 0.9,
        padding: new EdgeInsets.symmetric(horizontal: 20.0),
        children:modules.map((mid_module module)
    {
      return Container(
        child: Column(
         children: <Widget>[
           module.image_widget,
           Container(height: Size.width/50,),
           Text(module.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.deepOrangeAccent
           ,shadows: <BoxShadow>[new BoxShadow(color: Colors.orange,blurRadius: 1.0)]
           ),),
           Text(module.intro,style: TextStyle(fontSize: 10,color: Colors.grey),),
         ],
        ),
      );
    }).toList(),
    );
  }

  Widget getSearchRow()
  {
    /*
    对应顶部的搜索栏部分
     */
    return Container(
      margin: EdgeInsets.fromLTRB(Size.width/30, 0, Size.width/30, 0),
      height: Size.width/8,
      //decoration: BoxDecoration(color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
        GestureDetector(
          onTap: (){print("need write a route");},
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.search,color: Colors.orange,),
                Center(child: Text(" 友情 信工",style: TextStyle(color: Colors.grey,
                    fontWeight:FontWeight.w600,fontSize: 13),),),
              ],
            ),
          ),
        ),
         GestureDetector(
           onTap: (){print("历史纪录");},
           child:  Icon(Icons.history,color: Colors.grey,),
         )
        ]
      ),
    );
  }

  Widget get_compare_row(String text)
  {
    /*
    一个用于提示、界面分区的模块
     */
    return Container(
      margin: EdgeInsets.fromLTRB(Size.width/30, 0, Size.width/30, 0),
      height: Size.width/8,
      child: Row(
        children: <Widget>[
          Center(
            child: Text(text,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500,
                shadows: <BoxShadow>[new BoxShadow(color: Colors.grey,blurRadius: 2.0)]),),
          ),
          Container(width: Size.width/80,),
          Center(child: Icon(Icons.navigate_next),),
        ],
      ),
    );
  }

  Widget get_some_rank()
  {
    /*
    大厅有一部分展示前五名
     */
    List<Widget> widgets = [];
    for(int index = 0;index < 5;index++)
      {
        widgets.add(
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: Size.width/20,
              child:Row(
                children: <Widget>[
                  Text((index + 1).toString(), style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: getRankedUserColor(index),
                    shadows: [
                      Shadow(color: Colors.grey, blurRadius: 2)],),),
                  Container(width: Size.width/80,),
                  ClipOval(child: Image.network(
                    topList[index].img, fit: BoxFit.cover,
                    height: Size.width/ 12,
                  width: Size.width/12,),),
                  Container(width: Size.width/40,),
                  Text(topList[index].user_class,
                    style: TextStyle(fontSize: 14,color: getRankedUserColor(index)),),
                  Text("---",
                    style: TextStyle(fontSize: 13),),
                  Text(topList[index].name, style: TextStyle(fontSize: 14)),
                  Container(width: Size.width/4,),
                  Icon(Icons.star, color: Colors.amber,),
                  Text(topList[index].grade.toString(),
                    style: TextStyle(
                        fontSize: 24, color: getRankedUserColor(index)),
                  )
                ],
              ) ,
            ));
      }
   return GridView.count(
        physics: NeverScrollableScrollPhysics(),//这个属性
  crossAxisCount: 1,
  shrinkWrap: true,//这个属性
  mainAxisSpacing: 0.0,
  //crossAxisSpacing: 15.0,
  childAspectRatio: 7.0,
    padding: new EdgeInsets.symmetric(horizontal: 20.0),
   children: widgets,
   );
  }

  Widget get_all_problems()
  {
    /*
    对应大厅界面最后的部分展示出所有的心理问题
     */
    List<Problem> problems = [];
    List<Widget> widgets = [];
    problems.add(Problem(
      img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
      name: "李静涛",
      time: "2019-7-22",
      problem: "关于兄弟关系想找人聊一聊jlkjljkjlkjkljklhjlkhlkhlhlljljljl;jljjklhkhkhlkhljhljghjhkjghghjgjlkjkljkljkljklhlkhkh"
          "ljlkjlkjhjgl;j",
    ));
    problems.add(Problem(
      img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
      name: "李静涛",
      time: "2019-7-22",
      problem: "关于兄弟关系想找人聊一聊",
    ));
    problems.add(Problem(
      img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
      name: "李静涛",
      time: "2019-7-22",
      problem: "关于兄弟关系想找人聊一聊",
    ));
    problems.add(Problem(
      img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
      name: "李静涛",
      time: "2019-7-22",
      problem: "关于兄弟关系想找人聊一聊",
    ));
    for(int i = 0; i < problems.length;i++)
      {
        print(i);
        widgets.add(
          new Card(child:Column(
            children: <Widget>[
              Container(height: Size.width/50,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(width: Size.width/50,),
                      ClipOval(child: Image.network(
                        problems[i].img, fit: BoxFit.cover,
                        height: Size.width/12,width: Size.width/12,),),
                      Container(width: Size.width/50,),
                      Text(problems[i].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(width: Size.width/2,),
                  Text(problems[i].time,style: TextStyle(color: Colors.grey),),
                ],
              ),
              Container(
                height: Size.width/50,
              ),
              Container(
                //tease显示的文字内容
                //color: Colors.red,
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,),
                alignment: Alignment.bottomLeft,
                child: Text(problems[i].problem,style: TextStyle(fontSize: 16),maxLines: 3,softWrap: false,
                    overflow: TextOverflow.ellipsis,
                 ),
              ),
              Container(
                height: Size.width/60,
              ),
              Row(
                children: <Widget>[
                  Container(width: Size.width/2*1.2,),
                  Container(
                    //decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey),color: Colors.cyanAccent),
                    margin: EdgeInsets.only(right: 0),
                    child: FlatButton.icon(onPressed: (){print("我要解决");}, icon: Icon(Icons.highlight,color: Colors.green,),
                        label: Text("聊一聊",style: TextStyle(color: Colors.green),)),
                  ),
                ],
              )
            ],
          ),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0),),),));
      }
    return Column(
      children: widgets,
    );
  }
  Widget _getCourtList()
  {
    /*
    大厅界面
     */
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getSearchRow(),
          SwiperView(),
          Container(height: Size.width/15,),
          getModulesPart(),
          get_compare_row("地大最受认可的心理师"),
          get_some_rank(),
          Container(height: Size.width/30,),
          get_compare_row("所有等待交流的问题"),
          get_all_problems(),
        ],
      ),
    );
  }

  Color getRankedUserColor(int index)
  {
    /*
    根据名次给予不同的颜色，第一名、第二名、第三名分别是金、银、铜，其余一个颜色
     */
    if(index == 0)
      return Color(0xFFFFD700);
    else if(index == 1)
      return Color(0xFFC0C0C0);
    else if(index == 2)
      return Color(0xFFB87333);
    else
      return Color(0xFFDBDB70);
  }
  Widget _getRatedPage(BuildContext context)
  {
    /*
    排行榜界面
     */
   return  Column(
     children: <Widget>[
       new Expanded(
           child: GridView.builder(
         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 1,
             mainAxisSpacing: 0,
             childAspectRatio: 3.2),
         itemBuilder: (BuildContext context, int index) {
           return _getRatedPageItemIndex(context,index);
         },
         itemCount: topList.length,
       )),
     ],
   );
  }

  Widget _getRatedPageItemIndex(BuildContext context,int index) {
    /*
    帮助_getRatedPage根据index得到正确的item值
     */
    int order = 1; //名次
    print(index);
      return Container(
        height: screen_wide / 9,
        width: screen_wide,
        //margin: EdgeInsets.symmetric(vertical: screen_wide/100),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey))),
        child: Padding(
            padding: EdgeInsets.all(MediaQuery
                .of(context)
                .size
                .width / 50),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                        width: screen_wide / 6,
                        height: screen_wide / 4,
                        //decoration: BoxDecoration(color: Colors.red),
                        child: Column(
                          children: <Widget>[
                            Text((index + order).toString(), style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              color: getRankedUserColor(index),
                              shadows: [
                                Shadow(color: Colors.grey, blurRadius: 2)],),),
                            ClipOval(child: Image.network(
                              topList[index].img, fit: BoxFit.cover,
                              height: screen_wide / 8,),),
                          ],
                        )
                    ),
                    Container(
                      width: screen_wide / 2,
                      height: screen_wide / 4,
                      //decoration: BoxDecoration(color: Colors.red),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(screen_wide / 90),
                                width: screen_wide / 6 * 5,
                                height: screen_wide / 15,
                                child: Row(
                                  children: <Widget>[
                                    Text("姓名: ", style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                                    Text(topList[index].name,
                                      style: TextStyle(fontSize: 14),),
                                  ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(screen_wide / 90),
                                width: screen_wide / 6 * 5,
                                height: screen_wide / 15,
                                child: Row(
                                  children: <Widget>[
                                    Text("学院: ", style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w700),),
                                    Text(topList[index].college,
                                      style: TextStyle(fontSize: 14),),
                                  ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(screen_wide / 90),
                                width: screen_wide,
                                height: screen_wide / 15,
                                child: Stack(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text("专业班级: ", style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),),
                                        Text(topList[index].expert + "\n" +
                                            topList[index].user_class,
                                          style: TextStyle(fontSize: 14),)
                                      ],
                                    )
                                  ],
                                )
                            ),
                            Container(height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: screen_wide / 2 * 1.1 + screen_wide / 6.5,
                  child: Container(
                      padding: EdgeInsets.all(screen_wide / 90),
                      width: screen_wide,
                      height: screen_wide / 15,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.amber,),
                          Text(topList[index].grade.toString(),
                            style: TextStyle(
                                fontSize: 24, color: getRankedUserColor(index)),
                          )
                        ],
                      )
                  ),
                ),
                Positioned(
                  left: screen_wide / 2 * 1.15 + screen_wide / 6.5,
                  top: screen_wide / 8 * 0.8,
                  child: Container(
                      height: screen_wide / 2,
                      //color: Color(0x5FFF0000),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "帮助", style: TextStyle(color: Colors.grey),),
                                Text(topList[index].solved_problems.toString(),
                                  style: TextStyle(fontSize: 15,
                                      color: getRankedUserColor(index)),),
                                Text(
                                  "人", style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                Positioned(
                    left: screen_wide / 2 * 1.33 + screen_wide / 6.5,
                    top: screen_wide / 6 * 1.2,
                    child: GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            IconData(0xe512, fontFamily: 'PIcons'), size: 18,),
                          Text(topList[index].love_number.toString(),
                            style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      onTap: () {
                        print("点赞");
                      },
                    )
                )
              ],
            )
        ),
      );
  }

  @override
  void initState()
  {
    /*
    初始化topList
     */
    if(topList.length == 0)
    {
      topList.add(new account(college:"信工",solved_problems:20,grade: 150, name:"范泽奇", expert:"信息工程",
          love_number: 10,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
      topList.add(new account(college:"信工",solved_problems:15,grade: 130, name:"范泽奇", expert:"信息工程",love_number: 6,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
      topList.add(new account(college:"信工",solved_problems:10,grade: 50, name:"范泽奇", expert:"信息工程",love_number: 5,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
      topList.add(new account(college:"信工",solved_problems:20,grade: 150, name:"范泽奇", expert:"信息工程",love_number: 8,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
      topList.add(new account(college:"信工",solved_problems:15,grade: 130, name:"范泽奇", expert:"信息工程",love_number: 11,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
      topList.add(new account(college:"信工",solved_problems:10,grade: 50, name:"范泽奇", expert:"信息工程",love_number: 14,
          user_class:"117171", img:"https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg"));
    }
  }

  void getModuleItem()
  {
    modules.add(mid_module(
      image_widget:new ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: new Image.asset('images/intimate_module.jpg',fit: BoxFit.cover,height: Size.width/6,width:Size.width/6 ,),
      ),
      name: "同学美文",
      intro: "地大人自己的鸡汤",
      info: "目前投稿14篇",
    ));
    modules.add(mid_module(
      image_widget:new ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: new Image.asset('images/intimate_module3.jpg',fit: BoxFit.cover,height: Size.width/6,width:Size.width/6 ,),
      ),
      name: "男生世界",
      intro: "走进地大男生的世界",
      info: "如今住着20名男孩子",
    ));
    modules.add(mid_module(
      image_widget:new ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: new Image.asset('images/intimate_module2.jpg',fit: BoxFit.cover,height: Size.width/6,width:Size.width/6 ,),
      ),
      name: "女生世界",
      intro: "走进地大女生的闺房",
      info: "如今住着30名女孩子",
    ));
  }

  void init_intimate_court_state(BuildContext context)  //初始化选择的标题
  {
    tabTitles = [
      "排行榜",
      "大厅",
      "我的对话",
    ];
    tabBarViewChildren = [  // /选择的widget
      User_center(),
      _getCourtList(),
      _getRatedPage(context),
    ];
  }

  Widget _tabBar()  //选择Bar
  {
    return TabBar(
      controller: mController,
      tabs: tabTitles.map((String item){
        return Tab(child: Text(item),);
      }).toList(),
    );
  }

  Widget _tabBarView()   //视图
  {
    return TabBarView(
      controller: mController,
      children: tabBarViewChildren.map((item){
        return Center(
          child: Container(
            child: item,
          ),
        );
      }).toList(),
    );
  }
  @override
  void dispose()
  {
    super.dispose();
    mController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size.width = MediaQuery.of(context).size.width;
    Size.height = MediaQuery.of(context).size.height;
    getModuleItem();
    init_intimate_court_state(context);
    screen_wide = MediaQuery.of(context).size.width;
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title:  Center(child: Text("心灵苑           ")),  //空格填充返回按钮区域
          bottom: _tabBar(),
          backgroundColor: Colors.cyan,
        ),
        body:_tabBarView(), //各个视图
      ),
      length: tabTitles.length,
    );
  }
}


void main()
{
  runApp(new MaterialApp(home:intimate_court()));
}