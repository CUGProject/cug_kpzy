/*
对应问题会所里题目部分的数据结构
 */

import 'package:flutter/material.dart';

//得到题目所有图片对应的widget集合
Widget get_images_widget(String url)
{
  return Container(
    decoration: BoxDecoration(
      image: new DecorationImage(
        // fit:BoxFit.fill,
          image: new NetworkImage(url, scale: 1.2)),
    ),
  );
}

List<Tough_pro_ds> tough_problems = [
  new Tough_pro_ds(subject:"大一物理",time: "2019-6-22",widget_url: [
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1829003956,2333900472&fm=27&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3680625657,3752603465&fm=27&gp=0.jpg"],
    problem_text: "想了一晚上了都不会",
    usrname: "小明",
    existing_time: "十小时前",
    cur_state: "未解答",
    college: "信工学院",
    user_url:"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=1470837535,291171715&fm=85&s=A73653855070B79EF104895D0300D061",
  ),
  new Tough_pro_ds(subject:"大一物理",time: "2019-6-22",widget_url: [
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1829003956,2333900472&fm=27&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3680625657,3752603465&fm=27&gp=0.jpg",
  ],
    problem_text: "想了一晚上了都不会",
    usrname: "小明",
    existing_time: "十小时前",
    college: "信工学院",
    cur_state: "未解答",
    user_url:"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=1470837535,291171715&fm=85&s=A73653855070B79EF104895D0300D061",
  ),
  new Tough_pro_ds(subject:"大一物理",time: "2019-6-22",widget_url:
    ["https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1829003956,2333900472&fm=27&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3680625657,3752603465&fm=27&gp=0.jpg"],
    problem_text: "想了一晚上了都不会",
    usrname: "小明",
    existing_time: "十小时前",
    cur_state: "未解答",
    college: "信工学院",
    user_url:"https://ss0.baidu.com/73x1bjeh1BF3odCf/it/u=1470837535,291171715&fm=85&s=A73653855070B79EF104895D0300D061",
  ),

];

//对应界面listView中问题，因为之后会刷新更新，所以将tough_problems的复制一份，不使用同一个list
List<Tough_pro_ds> problems = tough_problems;
class Tough_pro_ds
{
  String subject;//对应哪门科目
  String time;//该问题提出时间
  String problem_text;//对应的问题发表时的文本部分
  String user_url;//提问者头像
  String usrname;//用户名
  String college;//学院
  String cur_state;//当前状态，已解答/未解答
  String existing_time;//该问题提出至今时间
  List<String> widget_url;//相关图片的url,最多两张图
  List<Widget> widget_set;//根据图片的url构造widget
  Tough_pro_ds({this.subject,this.time,this.problem_text,this.existing_time,this.usrname,this.college,
  this.widget_url,this.user_url,this.cur_state})
  {
    widget_set = [];
    if(widget_url.length > 0) {
      for (int i = 0; i < widget_url.length; i++) {
        widget_set.add(get_images_widget(widget_url[i]));
      }
    }

  }
}