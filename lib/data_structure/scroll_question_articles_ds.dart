import 'package:flutter_ui_framework/data_structure/one_article_ds.dart';
//该类针对每篇文章的信息所建
class Article {
  String headUrl;//头像url
  String title;//标题
  int agreeNum;//点赞数
  String id;//文章的id
  int commentNum;//评论数
  int money;//赏金数
  Article({this.headUrl,this.money,this.title,this.agreeNum,this.commentNum,this.id});
}

List<Article> articleList = [
  new Article(
      headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
      title: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢？",
      agreeNum: 10,
      money: 5,
      id: "2019-9-23-4-15",
      commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢？",
    agreeNum: 10,
    id: "2019-9-23-4-15",
    money: 5,
    commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),
];