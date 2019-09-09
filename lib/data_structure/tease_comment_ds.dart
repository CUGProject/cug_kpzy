import 'package:flutter/material.dart';
/*
本数据结构为吐槽详情展示的评论区代码
 */

class Tease_comment_ds
{
  String head_url;//头像url
  String user_name;//用户名
  String college;//学院
  String time;//时间
  String comment_text;//吐槽内容
  int upItNum;//点赞数
  Color comment_dz_color;//评论点赞的颜色
  Map<String,String> reply;//所有回复
  Tease_comment_ds({this.head_url,this.user_name,this.college,this.comment_text,this.comment_dz_color=Colors.black54,this.reply,this.time,this.upItNum});
}

Tease_comment_ds  tease_comment_example = new Tease_comment_ds(head_url: "https://pic3.zhimg.com/50/2b8be8010409012e7cdd764e1befc4d1_s.jpg",
user_name: "李明",
  college: "公共管理学院",
  comment_text: "我赞同",
  time: "今天3:15",
  upItNum: 56,
  reply: {"小王":"赞同","小丽":"说的不对"}
);