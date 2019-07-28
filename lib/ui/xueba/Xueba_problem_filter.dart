import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Xueba_problem_filter extends StatefulWidget {
  @override
  _AnimationFirstDemoState createState() => _AnimationFirstDemoState();
}

class _AnimationFirstDemoState extends State<Xueba_problem_filter> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  List<String> sorts = [
    '大一物理',
    '数学',
    '经济',
    '旅游',
    '人文',
    '逻辑',
  ];

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    );

    animation = new Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                height: animation.value/2*1.6, //和第54行保持一致
                width: MediaQuery.of(context).size.width/6,
                child: ListView(
                  children: List.generate(sorts.length, (i) {
                    return GestureDetector(
                      child: Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        height: animation.value/2*1.6/sorts.length,
                        child:Text(sorts[i]),
                      ),
                      onTap: () {
                        print(i);
                        controller.reverse();
                      });
                  }),
                )
            ),
          ],

    );
  }
  dispose() {
    controller.dispose();
    super.dispose();
  }
}