import 'package:flutter/material.dart';
/*
接口：ImageVidwoView(List<Widget>)
参数表：List<Widget> 组件列表
 */
/*
void main(){
  List<Widget> w_list = List();
  w_list.add(Image.network("http://n.sinaimg.cn/photo/transform/700/w1000h500/20190726/bdc9-iakuryw4236269.jpg"));
  w_list.add(Image.network("http://n.sinaimg.cn/news/transform/700/w1000h500/20190722/3fcc-iaantfi6526263.jpg"));
  w_list.add(Image.network("http://n.sinaimg.cn/news/transform/700/w1000h500/20190722/5e4c-iaantfi4892968.jpg"));
  runApp(ImageVideoView(w_list));
}
 */

class ImageVideoView extends StatefulWidget {
  List<Widget> w_list = List();
  int index;
  ImageVideoView(this.w_list,this.index);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageVideoViewState(w_list,index);
  }
}

class ImageVideoViewState extends State<ImageVideoView>{
  List<Widget> w_list = List();
  PageController controller;
  int index;//初始index
  ImageVideoViewState(this.w_list,this.index)
  {
    controller = PageController();
    if(controller.hasClients)
      {
        controller.animateToPage(index, duration: null, curve: null);
      }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: PageView.custom(
          controller: controller,
          childrenDelegate: SliverChildBuilderDelegate(
                  (context,index){
                return Center(
                  child: w_list[index],
                );
              },
              childCount: w_list.length
          ),
        ),
      ),
    );
  }
}