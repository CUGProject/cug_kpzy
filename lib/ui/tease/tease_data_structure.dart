/*
author:李静涛
该文件对应每个吐槽的数据结构
 */
import 'package:flutter/material.dart';
class Tease_ds
{
  String headUrl;//头像url
  String user;//用户名
  String userCollege;//用户学院
  String kind;//吐槽种类
  String time;//吐槽时间
  String content_title;//吐槽内容,后期如果内容过多，可以只显示前几行或者标题
  Map<String,String> great_comment; //精彩评论
  List<String> widget_set2;//吐槽内容,支持多种widget的url
  List<Widget> widget_set;//存放widget
  int  upItNum;//点赞数
  int commentNum;//评论数
  Tease_ds({this.headUrl,this.user,this.userCollege,this.kind,this.time,this.content_title,
      this.great_comment,this.upItNum,this.commentNum,this.widget_set2})
  {
    widget_set = [];
    for(int i = 0;i < widget_set2.length;i++)
      {
        print(widget_set2[i]);
        widget_set.add(get_test_widget(widget_set2[i]));
      }
  }
}

//对应滚动栏的吐槽
String test_url = "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg";
Widget get_test_widget(String url) {
  return Container(
    decoration: BoxDecoration(
      image: new DecorationImage(
        // fit:BoxFit.fill,
          image: new NetworkImage(url, scale: 1.2)),
    ),
  );
}

//对应精彩吐槽公布栏的吐槽
Widget test_widget_great = Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(const Radius.circular(12)),
    image: new DecorationImage(
        fit:BoxFit.fitWidth,
        image: new NetworkImage("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg",scale: 1.2)),
  ),
);
//对应滚动屏的吐槽list
List<Tease_ds> scroll_tease = [
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    great_comment: {"小明":"我也觉得是","小丽":" +1+1+1......"},
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url,test_url,test_url,test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    great_comment: {"小明":"我也觉得是","小丽":" +1+1+1......"},
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url,test_url,test_url,test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    great_comment: {"小明":"我也觉得是","小丽":" +1+1+1......"},
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url,test_url,test_url,test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
];
//对应优质吐槽公告栏的list
List<Tease_ds> teaseList = [
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
  new Tease_ds(
    headUrl: "http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
  new Tease_ds(
    headUrl: "https://pic3.zhimg.com/50/v2-8943c20cecab028e19644cccf0f3a38b_s.jpg",
    user: "李静涛",
    userCollege: "信息工程学院",
    kind: "学习",
    time: "2019-6-4",
    content_title: "老师讲课只吹牛逼",
    widget_set2:[test_url] ,
    upItNum: 500,
    commentNum: 1000,
  ),
];

