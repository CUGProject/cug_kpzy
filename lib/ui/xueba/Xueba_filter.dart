import 'package:flutter/material.dart';

class PopupMenuButtonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PopupMenuButtonDemo();
}

class _PopupMenuButtonDemo extends State<PopupMenuButtonDemo> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[_popMenu()],
      ),
      body: Center(
        child: RaisedButton(
          child: Text(_selectedValue == null ? '未选择' : _selectedValue),
          onPressed: () {
            _showMenu(context);
          },
        ),
      ),
    );
  }

  String _selectedValue;

  PopupMenuButton _popMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => _getPopupMenu(context),
      onSelected: (String value) {
        print('onSelected');
        _selectValueChange(value);
      },
      onCanceled: () {
        print('onCanceled');
      },
//      child: RaisedButton(onPressed: (){},child: Text('选择'),),
      icon: Icon(Icons.shopping_basket),
    );
  }

  _selectValueChange(String value) {
    setState(() {
      _selectedValue = value;
    });
  }

  _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    var pop = _popMenu();
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: position,
    ).then<void>((String newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '语文',
        child: Text('语文'),
      ),
      PopupMenuItem<String>(
        value: '数学',
        child: Text('数学'),
      ),
      PopupMenuItem<String>(
        value: '英语',
        child: Text('英语'),
      ),
      PopupMenuItem<String>(
        value: '生物',
        child: Text('生物'),
      ),
      PopupMenuItem<String>(
        value: '化学',
        child: Text('化学'),
      ),
    ];
  }
}

