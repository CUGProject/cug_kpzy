import 'package:flutter_ui_framework/utils/databaseUtils.dart';

/*

本代码使用DatabaseUtil类来创建、保存、提取前端用户信息

用户信息包括
学号 文本 id
班级号 文本
用户名 文本
头像url 文本

 */

class User
{
  DatabaseUtil dbhelper;
  User()
  {
    dbhelper = new DatabaseUtil(database_name: "kpzy_user",table_name: "user");
  }
  Future<void> insert_fake_data() async {
    String sql =  'INSERT INTO user VALUES("20171003196","117173","Unrivaled","http://tva2.sinaimg.cn/crop.0.3.707.707.180/a2f7c645jw8f6qvlbp1g7j20js0jrgrz.jpg")';
    dbhelper.insert(sql);
  }
  Future<List<Map>> get_user_data() async{
    String sql = 'SELECT * FROM user';
    Future<List<Map>> userInfo = dbhelper.query(sql);
    return userInfo;
  }
}
