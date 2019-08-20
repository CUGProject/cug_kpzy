import 'package:flutter/material.dart';

/*
本界面对应的是吐槽筛选界面，筛选条件有
吐槽类型： 学习 感情 生活等
学院： 信工 经管等
性别： 男 女
年级： 大一 大二 大三 大四
 */
void main()
{
  runApp(new MaterialApp(home:new Tease_filter(),));
}

class Tease_filter extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Tease_filter();
  }
}
class _Tease_filter extends State<Tease_filter>
{
  List<Map<String,int>> kind_filters = [
    {"学习":0}, {"人际":1}, {"爱情":2},{"家人":3},{"学校":4},{"生活":5}
  ];
  List<int> kind_mark_choose = [
    0,0,0,0,0,0
  ];
  List<Color> kind_filter_colors = [
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF)
  ];

  List<Map<String,int>> college_filters = [
    {"信工":0}, {"经管":1}, {"地空":2},{"环境":3},{"资源":4},{"公管":5},
    {"地质":6}, {"工程":7}, {"珠宝":8},{"地球科学":9},{"海洋":10},{"数理":11},
    {"李四光":12}, {"国际教育":13}, {"材化":14},{"自动化":15},{"艺媒":16},{"高等教育":17},
    {"计算机":18}, {"马院":19},{"机电":20},{"外院":21},
    {"体育":22},
  ];
  List<int> college_mark_choose = [
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  ];
  List<Color> college_filter_colors = [
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),
  ];

  List<Map<String,int>> grade_filters = [
    {"大一":0}, {"大二":1}, {"大三":2},{"大四":3},
  ];
  List<int> grade_mark_choose = [
    0,0,0,0,
  ];
  List<Color> grade_filter_colors = [
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),
  ];

  List<Map<String,int>> sex_filters = [
    {"男生发表":0}, {"女生发表":1},
  ];
  List<int> sex_mark_choose = [
    0,0,
  ];
  List<Color> sex_filter_colors = [
    Color(0xFFFFFFFF),Color(0xFFFFFFFF),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.clear,color: Colors.black,),
    backgroundColor: Colors.white,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/4 ),
        child: Text("筛选",style: TextStyle(color: Color(0xFA4F4F4F),
    fontSize: 20,
    //shadows:<BoxShadow>[new BoxShadow(color: Colors.grey,//阴影颜色
    //blurRadius: 1.0,)])),
      //),
    )),),),
      body: get_body(),

    );
  }
  Widget get_kind_filter_gridview( List<Map<String,int>> filters,List<int> choose, List<Color> colors)
  {
    /*
    返回一个包含类型选择的GridView
     */

      return GridView.count(
          physics: NeverScrollableScrollPhysics(),//这个属性
          crossAxisCount: 4,
          shrinkWrap: true,//这个属性
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.912,
          padding: new EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
          children: filters.map((Map<String,int> content){
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(color:colors[(content.values.toList()[0].abs())],border: Border.all(color: Color(0xFFB5B5B5)),borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(child: Text(content.keys.toList()[0]),),
              ),
              onTap:(){if(choose[content.values.toList()[0].abs()] == 0)
                {
                  setState(() {
                    print("change color");
                    colors[content.values.toList()[0].abs()] = Colors.cyan;
                    choose[content.values.toList()[0].abs()] = 1;
                    print(choose[content.values.toList()[0].abs()]);
                  });
                }else{
                setState(() {
                  print("change color back");
                  colors[content.values.toList()[0]] = Colors.white;
                  choose[content.values.toList()[0].abs()] = 0;
                });
              }
              } ,
            );
          }).toList()
      );
  }
  Widget get_body()
  {
    /*
    返回scaffold 的body
     */
    return SingleChildScrollView(
      //physics: new NeverScrollableScrollPhysics(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.width/15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/20,),
              child: Text("吐槽类型",style: TextStyle(color: Color(0xFE363636),fontSize: 17,fontWeight: FontWeight.w700,
              letterSpacing: 1),),
            ),
            Container(height: MediaQuery.of(context).size.width/20,),
            get_kind_filter_gridview(kind_filters,kind_mark_choose,kind_filter_colors),

            Container(height: MediaQuery.of(context).size.width/15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/20,),
              child: Text("性别",style: TextStyle(color: Color(0xFE363636),fontSize: 17,fontWeight: FontWeight.w700,
                  letterSpacing: 1),),
            ),
            Container(height: MediaQuery.of(context).size.width/20,),
            get_kind_filter_gridview(sex_filters,sex_mark_choose,sex_filter_colors),

            Container(height: MediaQuery.of(context).size.width/15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/20,),
              child: Text("年级",style: TextStyle(color: Color(0xFE363636),fontSize: 17,fontWeight: FontWeight.w700,
                  letterSpacing: 1),),
            ),
            Container(height: MediaQuery.of(context).size.width/20,),
            get_kind_filter_gridview(grade_filters,grade_mark_choose,grade_filter_colors),

            Container(height: MediaQuery.of(context).size.width/15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/20,),
              child: Text("学院",style: TextStyle(color: Color(0xFE363636),fontSize: 17,fontWeight: FontWeight.w700,
                  letterSpacing: 1),),
            ),
            Container(height: MediaQuery.of(context).size.width/20,),
            get_kind_filter_gridview(college_filters,college_mark_choose,college_filter_colors),
            Container(height: MediaQuery.of(context).size.width/20,),
            GestureDetector(
              onTap: (){print("确定");},
              child: Container(
                height: MediaQuery.of(context).size.width/8,
                child: Center(child: Text("确定",style: TextStyle(fontSize: 19,letterSpacing: 7,fontWeight: FontWeight.w600),),),
                decoration: BoxDecoration(color: Colors.cyan),
              ),
            )
          ]
      ),);
  }
}


