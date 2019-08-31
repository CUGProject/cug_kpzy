import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
sqflite: ^1.1.0
path_provider: ^0.4.0
 */

/*
本代码封装类DatabaseUtil提供前端数据库操作接口
接口构造函数
DatabaseUtil({this.database_name,this.table_name});
 */

class DatabaseUtil
{
  String database_name;
  String table_name;
  DatabaseUtil({this.database_name,this.table_name});
  Future<String> get _dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$database_name.db");
    return path;
  }

  Future<Database> get _localFile async {
    final path = await _dbPath;
    String create_table_sql = "CREATE TABLE $table_name ("
        "studentNumber TEXT PRIMARY KEY,"
        "class TEXT,"
        "user_name TEXT,"
        "image_url TEXT)";
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              create_table_sql
          );
          print('create successfully');
        });
    return database;
  }

  Future<int> insert(String sql) async {
    final db = await _localFile;
    int mark = await db.transaction((trx){
      trx.rawInsert(sql);
    });
    print(mark);
    return mark;
  }

  Future<List<Map>> query(String sql) async {
    final db = await _localFile;
    List<Map> list=    await db.rawQuery(sql);
    print(list);
    return list;
  }
  Future<int> update(String sql) async {
    final db = await _localFile;
    int list=    await db.rawUpdate(sql);
    print(list);
    return list;
  }
  Future<int> delete(String sql) async {
    final db = await _localFile;
    int list=    await db.rawDelete(sql);
    print(list);
    return list;
  }
}


/*
void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

class MyApp extends StatelessWidget {
  final _userNameController = new TextEditingController();
  DatabaseUtil dbhelper = new DatabaseUtil();
  @override
  Widget build(BuildContext context) {
    return new Builder(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("FileOperator"),
        ),
        body: new Center(
          child: new Builder(builder: (BuildContext context) {
            return new Column(
              children: <Widget>[
                new TextField(
                  controller: _userNameController,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 10.0),
                      icon: new Icon(Icons.perm_identity),
                      labelText: "请输入用户名",
                      helperText: "注册时填写的名字"),
                ),
                RaisedButton(
                    color: Colors.blueAccent,
                    child: Text("插入"),
                    onPressed: () {
                      String sql =  'INSERT INTO user(name) VALUES("l22l")';
                      dbhelper.insert(sql);
                      Scaffold.of(context).showSnackBar(
                          new SnackBar(content: new Text("数据插入成功")));
                    }),
                RaisedButton(
                    color: Colors.greenAccent,
                    child: Text("获取"),
                    onPressed: () {
                      String sql = 'SELECT * FROM user';
                      Future<List<Map>> userName = dbhelper.query(sql);
                      userName.then((List<Map> userNames) {
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: Text("数据获取成功：$userNames")));
                      });
                    }),
                RaisedButton(
                    color: Colors.greenAccent,
                    child: Text("更新"),
                    onPressed: () {
                      String sql = 'update user set name = "李涛" where id = 1';
                      dbhelper.update(sql);
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: Text("数据更新成功"))
                      );
                    },),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("删除"),
                  onPressed: () {
                    String sql = 'delete from  user  where id = 2';
                    dbhelper.update(sql);
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: Text("数据删除成功"))
                    );
                  },),
              ],
            );
          }),
        ),
      );
    });
  }
}
 */