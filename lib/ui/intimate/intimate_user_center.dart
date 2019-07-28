import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/ui/intimate/intimate_court.dart';

class User_center extends StatefulWidget
{
  /*
  对应心灵苑的个人中心
   */
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _User_center();
  }
}
class Answerer{
  String img;
  String name;
  String time;
  int star_number;
  Answerer({this.time,this.img,this.name,this.star_number});
}

class Size
{
  static double width;
  static double height;
}
class _User_center extends State<User_center> with TickerProviderStateMixin
{
  bool visible = true;//控制当前问题显示可见与否
  bool visible2 = true;//控制历史问题显示可见与否
  Color visiable_color;//可见时颜色
  Widget get_one_problem(Problem problem)
  {
    /*
    根据probelm返回和大厅一样的card
     */
    return new Card(child:Column(
      children: <Widget>[
        Container(height: Size.width/50,),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: Size.width/50,),
                ClipOval(child: Image.network(
                  problem.img, fit: BoxFit.cover,
                  height: Size.width/10,width: Size.width/10,),),
                Container(width: Size.width/50,),
                Text(problem.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              ],
            ),
            Container(width: Size.width/2,),
            Text(problem.time,style: TextStyle(color: Colors.grey),),
          ],
        ),
        Container(
          height: Size.width/50,
        ),
        Container(
          //color: Colors.red,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50,),
          alignment: Alignment.bottomLeft,
          child: Text(problem.problem,style: TextStyle(fontSize: 16),maxLines: 3,softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: Size.width/50,
        )
      ],
    ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0),),),);
  }
  Widget get_doing_problems(Problem problem,List<Answerer> answerer)
  {
    /*
    得到正在进行的聊天的部分
     */
    List<Widget> widgets = [];
    for(int i = 0 ;i < answerer.length;i++)
      {
        widgets.add(Container(
          margin: EdgeInsets.only(top: Size.width/50),
                child:Row(
                  children: <Widget>[
                    Container(width: Size.width/50,),
                    ClipOval(child: Image.network(
                      answerer[i].img, fit: BoxFit.cover,
                      height: Size.width/12,width: Size.width/12,),),
                    Container(width: Size.width/50,),
                    Text(answerer[i].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                    Container(width: Size.width/2*1.07,),
                    Text(answerer[i].time,style: TextStyle(color: Colors.grey),),
                  ],
                )
            ));
      }
      return  Column(
          children: <Widget>[
            //Container(height: Size.width/25,),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Color(0xAFC0C0C0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  get_one_problem(problem),
                  Text("和我聊天的人: ",style: TextStyle(color: Colors.cyan,fontSize: 14,fontWeight: FontWeight.w600),),
                  ListView(
                    shrinkWrap: true,
                    children: widgets,
                  )
                ],
              ),
            ),
          ],
      );
  }
  Widget get_over_problems(Problem problem,List<Answerer> answerer)
  {
    /*
    得到已结束聊天的部分
     */
    List<Widget> widgets = [];
    List<Widget> stars = [];
    for(int i = 0 ;i < answerer.length;i++)
    {
      stars = [];
      for(int j = 0; j < answerer[i].star_number;j++)
        {
          stars.add(Icon(Icons.star,color: Colors.amber));
          stars.add(Container(width: Size.width/50,),);
        }
      widgets.add(Container(
          margin: EdgeInsets.only(top: Size.width/50),
          child:Row(
            children: <Widget>[
              Container(width: Size.width/50,),
              ClipOval(child: Image.network(
                answerer[i].img, fit: BoxFit.cover,
                height: Size.width/12,width: Size.width/12,),),
              Container(width: Size.width/50,),
              Text(answerer[i].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
              Container(width: Size.width/2*1.07,
              padding: EdgeInsets.symmetric(horizontal: Size.width/25),
              //decoration: BoxDecoration(color: Colors.red),
              child: Row(children: stars),),
              Text(answerer[i].time,style: TextStyle(color: Colors.grey),),
            ],
          )
      ));
    }
    return  Column(
      children: <Widget>[
        //Container(height: Size.width/25,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Color(0xAFC0C0C0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              get_one_problem(problem),
              Text("和我聊天的人: ",style: TextStyle(color: Colors.cyan,fontSize: 14,fontWeight: FontWeight.w600),),
              ListView(
                shrinkWrap: true,
                children: widgets,
              )
            ],
          ),
        ),
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    if(visible)
      visiable_color = Colors.orange;
    else
      visiable_color = Colors.black;
    Size.width = MediaQuery.of(context).size.width;
    Size.height = MediaQuery.of(context).size.height;
    TabController mcontroller = TabController(length: 2, vsync: this);
    // TODO: implement build
    return  Scaffold(
      body: NestedScrollView(
        //physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
        {
          return <Widget>[
            SliverAppBar(
              primary: true,// 预留状态栏
              forceElevated: false, //展开flexibleSpace之后是否显示阴影
              automaticallyImplyLeading: true,   // 如果有 leading 这个不会管用 ,相当于忽略这个参数 ； 如果没有leading ，当有侧边栏的时候， false：不会显示默认的图片，true 会显示 默认图片，并响应打开侧边栏的事件
//            titleSpacing: NavigationToolbar.kMiddleSpacing,//flexibleSpace 和 title 的距离 默认是重合的
              expandedHeight: 200.0,//200.0, 可滚动视图的高度  伸缩区域大小
              snap: true,//与floating结合使用
              floating: true, //是否随着滑动隐藏标题,滑动到最上面，再snap滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
              pinned: false,  //
              backgroundColor: Colors.cyan,// 是否固定在顶部,往上滑，导航栏可以隐藏
              leading:Icon(Icons.menu),
              flexibleSpace:
              FlexibleSpaceBar(
                //可以展开区域，通常是一个FlexibleSpaceBar
                centerTitle: true,
                title: _title(),
                background: Image.asset(
                  "images/intiUserCenter.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: <Widget>[
                Card(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/50),
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            new ClipOval(
                              child: new Image.network("https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",fit: BoxFit.cover,height: MediaQuery.of(context).size.width/6,
                                width:  MediaQuery.of(context).size.width/6,),
                            ),
                            Container(width: Size.width/25,),
                            Text("贝为佳",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.black),),
                          ],),
                          Container(height: Size.width/50,),
                          Row(
                            children: <Widget>[
                              //Container(width:Size.width/25),
                              Text("地理与信息工程学院",style: TextStyle(fontSize: 14),),
                              Container(width:Size.width/50),
                              Text("117172班",style: TextStyle(fontSize: 14),)
                            ],
                          ),
                          Container(height: Size.width/50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("提问 ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),),
                              Text("3 ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
                              Container(width: Size.width/20,),
                              Text("已解决 ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),),
                              Text("2 ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
                            ],
                          ),
                          Container(height: Size.width/20,)
                        ])),
                Container(height: Size.width/20,),
                Container(
                  width: Size.width,
                  height: Size.height/15,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.blue, Colors.white],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.0),
                      )
                  ),
                  margin: EdgeInsets.only(top: Size.width/25),
                  child: Center(child: Row(
                    children: <Widget>[
                      Container(width: Size.width/50,),
                      Icon(Icons.all_inclusive),
                      Container(width: Size.width/25,),
                      Text("正在进行的聊天......",style: TextStyle(fontSize: 16,),),
                      Container(width: Size.width/7*2,),
                      Container(
                        width: Size.width/7,
                        child: GestureDetector(
                          child: Icon(Icons.visibility,color: visiable_color,),
                          onTap: ()
                          {
                            setState(() {
                              if(visible)
                                visible = false;
                              else
                                visible = true;
                            });
                          },
                        ),
                      )
                    ],
                  )),
                ),
                Offstage(
                  offstage: visible,
                  child: Column(
                    children: <Widget>[
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          get_doing_problems(Problem(
                            img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
                            name: "贝为佳",
                            time: "2019-7-22",
                            problem: "关于兄弟关系想找人聊一聊",
                          ),
                              [Answerer(name: "小明",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1"),
                              Answerer(name: "小李",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1"),
                              Answerer(name: "小丽",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1"),
                              Answerer(name: "虎哥",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1")]),
                        ],
                      )
                    ],
                  ),
                ),
                Container(height: Size.width/50,),
                Container(
                  width: Size.width,
                  height: Size.height/15,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.blue, Colors.white],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.0),
                      )
                  ),
                  margin: EdgeInsets.only(top: Size.width/25),
                  child: Center(child: Row(
                    children: <Widget>[
                      Container(width: Size.width/50,),
                      Icon(Icons.all_inclusive),
                      Container(width: Size.width/25,),
                      Text("已结束的聊天",style: TextStyle(fontSize: 16,),),
                      Container(width: Size.width/7*3*0.95,),
                      Container(
                        width: Size.width/7,
                        child: GestureDetector(
                          child: Icon(Icons.visibility,color: visiable_color,),
                          onTap: ()
                          {
                            setState(() {
                              if(visible2)
                                visible2 = false;
                              else
                                visible2 = true;
                            });
                          },
                        ),
                      )
                    ],
                  )),
                ),
                Offstage(
                  offstage: visible2,
                  child: Column(
                    children: <Widget>[
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          get_over_problems(Problem(
                            img: "https://img2.woyaogexing.com/2019/06/03/299594e4813d4a48a2c72fb950583fbe!400x400.jpeg",
                            name: "贝为佳",
                            time: "2019-7-22",
                            problem: "关于兄弟关系想找人聊一聊",
                          ),
                              [Answerer(name: "小明",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1",star_number: 3),
                              Answerer(name: "小李",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1",star_number: 2),
                              Answerer(name: "小丽",img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1",star_number: 4),
                              Answerer(name: "虎哥",star_number:1,img: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg"
                                  ,time: "2019-8-1")]),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        )
        ));
  }
  _title() {
    /*
    标题
     */
    return Text("心灵苑个人中心",
        style: TextStyle(
          color: Colors.white,
          shadows: <BoxShadow>[BoxShadow(color: Colors.grey,blurRadius: 3)],
          fontSize: 15.0,
        ));
  }

}

void main()
{
  runApp(MaterialApp(home: User_center(),));
}