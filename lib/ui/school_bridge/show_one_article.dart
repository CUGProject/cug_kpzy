import 'dart:async';
import 'dart:convert';
import 'package:flutter_ui_framework/data_structure/show_one_article_ds.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
/*
本代码为高校对接中显示一篇文章的界面
 */
class ZefyrLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('MDEditor'),
      ],
    );
  }
}

class FullPageEditorScreen extends StatefulWidget {

  FullPageEditorScreen(this.note)
  {
    print("===================================");
    print(this.note);
  }
  final Note note;
  @override
  _FullPageEditorScreenState createState() => new _FullPageEditorScreenState();
}

class _FullPageEditorScreenState extends State<FullPageEditorScreen> {
  ZefyrController _controller;
  final FocusNode _focusNode = new FocusNode();
  bool _editing = false;
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(NotusDocument.fromDelta(
        Delta.fromJson(json.decode(widget.note.text) as List)));//1
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = new ZefyrThemeData(
      cursorColor: Colors.blue,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ZefyrScaffold(
        child: ZefyrTheme(
          data: theme,
          child: ZefyrEditor(
            physics: new NeverScrollableScrollPhysics(),
            controller: _controller,
            focusNode: _focusNode,
            enabled: _editing,
            imageDelegate: CustomImageDelegate(),
          ),
        ),
      ),
    );
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }
}

class CustomImageDelegate extends ZefyrDefaultImageDelegate {
  @override
  Widget buildImage(BuildContext context, String imageSource) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (imageSource.startsWith('asset://')) {
      final asset = new AssetImage(imageSource.replaceFirst('asset://', ''));
      return new Image(image: asset);
    } else {
      return super.buildImage(context, imageSource);
    }
  }
}