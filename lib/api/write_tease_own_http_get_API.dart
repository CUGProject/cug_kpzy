import 'dart:async';
import 'package:http/http.dart' as http;

/*
该接口是处理服务器的传回来数据的接收部分API
 */
const baseUrl = 'http://www.cugkpzy.com/show_tucao_module/';
int counter = -1; //记录第几次刷新
class API {
  static Future getTease() {
    counter += 1;
    print("本次刷新url------------------------------------------------------------");
    var url = baseUrl + counter.toString();
    print(url);
    return http.get(url);
  }
}
class Tease {
  String headUrl;//头像url
  String user;//用户名
  String userCollege;//用户学院
  String kind;//吐槽种类
  String time;//吐槽时间
  String content_title;//吐槽内容,后期如果内容过多，可以只显示前几行或者标题
  int  upItNum;//点赞数
  Map<String,String> great_comment;
  int commentNum;//评论数
  List<String> widget_set;//视频或图片对应String
  List<String> widget_set_2;//保存有视频video的url
  List<int> widget_mark;//一个包含0、1的list，代表是图片还是视频
  Tease(String headUrl,String user,String userCollege,String kind,List<String> widget_set_2,
      List<int> widget_mark,String time,String content_title,int upItNum,int commentNum,List<String> widget_set)
  {
    this.headUrl = headUrl;this.user = user;this.userCollege = userCollege;this.widget_set_2 = widget_set_2;
    this.kind = kind;this.time = time;this.content_title = content_title;this.widget_mark = widget_mark;
    this.upItNum = upItNum;this.great_comment = great_comment;this.commentNum = commentNum;this.widget_set = widget_set;
  }

  //解析json格式
  Tease.fromJson(Map json)
      :headUrl = json["headUrl"],
        user = json["user"],
        widget_set_2 = json["widget_set_2"].cast<String>(),
        userCollege = json["userCollege"],
        kind = json["kind"],
        time = json["time"],
        widget_mark = json["widget_mark"].cast<int>(),
        content_title = json["content_title"],
        upItNum = json["upItNum"],
        great_comment = json["great_comment"].cast<String,String>(),
        commentNum = json["commentNum"],
        widget_set = json["widget_set"].cast<String>();//强制类型转换

  //转成json格式
  Map toJson() {
    return {"headUrl":headUrl,"user":user,"userCollege":userCollege,"widget_mark":widget_mark,"widget_set_2":widget_set_2,
    "kind":kind,"time":time,"content_title":content_title,"upItNum":upItNum,"great_comment":great_comment,"commentNum":commentNum,
    "widget_set":widget_set
      };
  }
}