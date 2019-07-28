/*
* Time: 2019/5/30 12：00
* LastEditor: 范泽奇
* 接口：
*   1.course_management() -> 未完成构造函数
*   2.SubjectList()  -> AddSubject() SetData()
*       void AddSubject(int day,int subject,String full_name,Color background_color,String time,String teacher,String adress);
*         day：这节课第几天
*         subject：第几节课
*         full_name：课程名称
*         background_color：背景颜色
*         time：课程时间（第几周到第几周）
*         teacher：任课教师
*         adress：上课地点
*
*      void SetDate(int year,int month,int start_day)
*         year：年份
*         month：周一在那个月
*         start_day：周一在几号
*/

import 'package:flutter/material.dart';
//MyList 类

class SubjectList {
  int year = 2000;
  int month = 1;
  int start_day = 1;
  List<List<String>> full_name = List(7);        //全称
  List<List<Color>>  background_color = List(7); //背景颜色
  List<List<String>> time = List(7);             //课程时间
  List<List<String>> teacher = List(7);          //教师
  List<List<String>> adress = List(7);           //地点
  SubjectList()
  {
    year = 2000;
    month = 1;
    start_day = 1;
    for(int i=0;i<7;i++)
    {
      List<String> c_full_name = List(14);        //全称
      List<Color>  c_background_color = List(14); //背景颜色
      List<String> c_time = List(14);             //课程时间
      List<String> c_teacher = List(14);          //教师
      List<String> c_adress = List(14);           //地点
      for(int j=0;j<14;j++)
      {
        c_full_name[j] = "";
        c_background_color[j] = Colors.white;
        c_time[j] = "";
        c_teacher[j] = "";
        c_adress[j] = "";
      }
      full_name[i] = c_full_name;
      background_color[i] = c_background_color;
      time[i] = c_time;
      teacher[i] = c_teacher;
      adress[i] = c_adress;
    }
  }
  void AddSubject(int day,int subject,String full_name,Color background_color,String time,String teacher,String adress)
  {
    this.full_name[day-1][subject-1] = full_name;
    this.background_color[day-1][subject-1] = background_color;
    this.time[day-1][subject-1] = time;
    this.teacher[day-1][subject-1] = teacher;
    this.adress[day-1][subject-1] = adress;
  }
  void SetDate(int year,int month,int start_day)
  {
    this.year = year;
    this.month = month;
    this.start_day = start_day;
  }
}
class course_management extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Center(
            child: Text("我的课表",textAlign: TextAlign.center,),
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: MyList(),
    );
  }
}
class MyList extends StatefulWidget{
  @override
  MyList({Key key}):super(key:key);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyListState();
  }
}
class MyListState extends State<MyList>{
  @override
  int toch_id = -1;
  var sl = SubjectList();
  //--------------------------构造函数----------------------------------------------------------------------------------
  MyListState()  //初始化
  {
    //get list date from mysql
    sl.SetDate(2004,2, 28);
    sl.AddSubject(1, 1,"地质地貌学", Colors.lightBlue, "第一到五周", "李老师", "北综401");
    sl.AddSubject(1, 2,"地质地貌学", Colors.lightBlue, "第一到五周", "李老师", "北综401");
    sl.AddSubject(1, 3,"高等数学", Colors.deepPurpleAccent, "第二周到三周", "王老师", "北综401");//
    sl.AddSubject(1, 4,"高等数学", Colors.deepPurpleAccent, "第二周到三周", "王老师", "北综401");
    sl.AddSubject(1, 7,"马克思主义原理", Colors.purpleAccent, "第一周到十六周", "赵老师", "北综401");
    sl.AddSubject(1, 8,"马克思主义原理", Colors.purpleAccent, "第一周到十六周", "赵老师", "北综401");
    sl.AddSubject(3, 2,"线性代数", Colors.pink, "第一到五周", "高老师", "北综401");
    sl.AddSubject(3, 1,"线性代数", Colors.pink, "第一到五周", "高老师", "北综401");
  }
  //---------------------------------------------------------------------------------------------------------------------

  //--------------------------Widege获取----------------------------------------------------------------------------------
  int _getItemCount(int x)   //获取方框数量
  {
    if(x == 0)
      return 15;
    else
    {
      int zero_count = 0;  //默认值的个数
      var my_set = Set();
      for(int i=0;i<14;i++)
      {
        if(sl.full_name[x-1][i] == "")
          zero_count++;
        else my_set.add(sl.full_name[x-1][i]);
      }
      return my_set.length + zero_count + 1;
    }
  }
  Widget _getContiner(int x,int y)   //获取方框
  {
    if( x == 0 && y == 0)
    {
      return Container(
        height: MediaQuery.of(context).size.height/15,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white,width: 1),
          //borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(sl.month.toString() + "月",style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.w700)),
        ),
      );
    }
    else if(x == 0 && y!= 0)
    {
      return Container(
        height: MediaQuery.of(context).size.height/15*1.5,
        decoration: BoxDecoration(
          color:Color(0x00AABB),
          //border: Border.all(color: Colors.black12,width: 1),
          //borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text((y).toInt().toString()),
        ),
      );
    }
    else if(y == 0 && x > 0)
    {
      String text;
      switch(x)
      {
        case 1:text = "周一";break;
        case 2:text = "周二";break;
        case 3:text = "周三";break;
        case 4:text = "周四";break;
        case 5:text = "周五";break;
        case 6:text = "周六";break;
        case 7:text = "周天";break;
      }
      //设置日期换月份
      int n_mon = sl.month;
      int n_day = sl.start_day+x-1;
      if(n_mon != 2)
      {
        if(n_mon ==1 || n_mon ==3 || n_mon ==5 || n_mon ==7 || n_mon ==8 ||  n_mon ==10 || n_mon ==12)//1,3,5,7,8,10,12
            {
          if(n_day>31)
          {
            n_day = n_day % 31;
            n_mon++;
          }
        }
        else
        {
          if(n_day>30)
          {
            n_day = n_day % 30;
            n_mon++;
          }
        }
      }
      else
      {
        if(sl.year % 400 == 0 || (sl.year % 4 == 0 && sl.year % 100 != 0))
        {
          if(n_day>29)
          {
            n_day = n_day % 29;
            n_mon++;
          }
        }
        else
        {
          if(n_day>28)
          {
            n_day = n_day % 28;
            n_mon++;
          }
        }
      }
      //返回
      return Container(
          height: MediaQuery.of(context).size.height/15,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black12,width: 1),
            //borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(text+ "          " + n_mon.toString()+"/"+n_day.toString(),maxLines: 2,textAlign: TextAlign.center,style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.w500),),//空格用于保证换行
          )
      );
    }
    else if(x>0 && y>0)
    {
      int kx = x-1,ky = y-1;
      int percent_height = 1;
      int up = 0;  //下方格子数
      int p = 0;  //数据位置指针
      int temp = 0;  //查找个数
      int if_find = 0; //是否查找到
      //转换ky至数据相对位置
      for(p=0;p<13;p++)
      {
        if(sl.full_name[kx][p] == "")
        {
          temp++;
          if(temp -1 == ky)
          {
            if_find = 1;
            break;
          }
          continue;
        }
        else
        {
          for(;sl.full_name[kx][p] == sl.full_name[kx][p+1] && p<13 ;p++);
          temp++;
          if(temp -1 == ky)
          {
            if_find = 1;
            break;
          }
        }
      }
      if(if_find == 1)
        ky = p;
      //查早上方格个数
      if(sl.full_name[kx][ky] != "")
      {
        //查找上下格子个数
        if( ky == 0)  //第一行
            {
          up = 0;
        }
        else  //中间
            {
          for(int i = ky-1;i>=0;i--)
          {
            if(sl.full_name[kx][ky] == sl.full_name[kx][i])
              up++;
            else
              break;
          }
        }
      }
      Widget con;
      percent_height = percent_height + up;  //计算长度倍率
      if(sl.full_name[kx][ky] != "") {
        con = Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 15 * 1.5 * percent_height,
            decoration: BoxDecoration(
              color: Colors.white,),
            child: Center(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 15 * 1.5 * percent_height * 21 / 22,
                //padding: EdgeInsets.only(top: 30,bottom: 5),
                decoration: BoxDecoration(
                  color: sl.background_color[kx][ky],
                  boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(-4.0, -4.0),blurRadius: 8.0, spreadRadius: 1.0)],
                  border: Border.all(
                      color: sl.background_color[kx][ky], width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(sl.full_name[kx][ky] +
                      (sl.full_name[kx][ky] != "" ? "#" : "") +
                      sl.adress[kx][ky], textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            )
        );
      }else
      {
        con = Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 15 * 1.5 * percent_height,
          decoration: BoxDecoration(
            color: Colors.white,),
        );
      }
      return GestureDetector(   //操作控制
          onTap: () {
            if(sl.full_name[kx][ky] != "")
            {
              setState(_onTapBlock(kx,ky));
            }
          },
          child:  con
      );
    }
  }
  List<Widget> _getWidget()  //获取children每一列
  {
    List<Widget> ls = List();
    for(int i=0;i<8;i++)
    {
      ls.add(
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),   //禁止滑动
              itemCount: _getItemCount(i),
              itemBuilder: (BuildContext context,int index){
                return _getContiner(i, index);
              }
          )
      );
    }
    return ls;
  }
  Widget _getViewList()   //获取课程目录   //------------------》》未删除第一行用于占位2333
  {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid.count(
          childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height*8*1.469),
          crossAxisCount: 8,
          children: _getWidget(),
        )
      ],
    );
  }
  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------操作相关----------------------------------------------------------------------------------
  _onTapBlock(int kx,int ky)
  {
    showBottomSheet(context: context,
        builder: (BuildContext context){
          return Stack(
            children: <Widget>[
              Container(
                  color: sl.background_color[kx][ky] ,
                  padding: EdgeInsets.only(top: 30,left: 70),
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child:Stack(
                    children: <Widget>[
                      Positioned(
                        top: -5,
                        child: Text(sl.full_name[kx][ky] ,style: TextStyle(fontSize: 20,color: Colors.white)),
                      ),
                      Positioned(
                        top: 30,
                        child: Text("课程时间:" + sl.time[kx][ky] ,style: TextStyle(color:Colors.white)),
                      ),
                      Positioned(
                        top: 60,
                        child: Text("任课教师:" + sl.teacher[kx][ky],style: TextStyle(color:Colors.white) ),
                      ),
                      Positioned(
                        top: 90,
                        child: Text("课程地点:" + sl.adress[kx][ky],style: TextStyle(color:Colors.white) ),
                      ),
                    ],
                  )
              ),
            ],
          );
        });
  }
  List<Widget> _getTitleWidget()  //获取课程标题的continer
  {
    List<Widget> ls = List();
    for(int i=0;i<8;i++)
    {
      ls.add(_getContiner(i, 0));
    }
    return ls;
  }
  Widget _getTitle()  //获取课程标题GridView
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/15,
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 8,
        children: _getTitleWidget(),
      ),
    );
  }
  //---------------------------------------------------------------------------------------------------------------------

  //--------------------------Build----------------------------------------------------------------------------------
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        _getViewList(),
        _getTitle(),
      ],
    );
  }
//-------------------------------------------------------------------------------------------------------------------
}