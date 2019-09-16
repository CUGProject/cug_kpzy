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
    title: "地大今年招生分数大概是多少，孩子550，有把握么？",
    agreeNum: 10,
    id: "2019-9-23-4-15",
    money: 5,
    commentNum: 1000,
  ),
  new Article(
      headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
      title: "兴趣对于专业选择重要么？孩子喜欢数学，但是就业不太好",
      agreeNum: 10,
      money: 5,
      id: "2019-9-23-4-15",
      commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "我高考分数580，今年可以考上一个不错的211么？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),
  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "姐姐在上海上班，但是上海的好学校去不了，因为亲人在选择一个城市可以么？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),

  new Article(
    headUrl: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
    title: "平时成绩不错，高考考的很差，想着比同龄人小一岁，计划二战，值得么？",
    agreeNum: 10,
    money: 5,
    id: "2019-9-23-4-15",
    commentNum: 1000,
  ),
];