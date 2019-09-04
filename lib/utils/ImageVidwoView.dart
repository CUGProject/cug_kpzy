import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui_framework/utils/tap_widget_event.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_ui_framework/utils/i18n/i18n.dart';
import 'package:flutter_ui_framework/ui/tease/tease_data_structure.dart';
import 'package:chewie/chewie.dart';
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
  Tease_ds tease;
  ImageVideoView(this.w_list,this.index,this.tease);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageVideoViewState(w_list,index,tease);
  }
}

class ImageVideoViewState extends State<ImageVideoView>{
  List<Widget> w_list = List();
  PageController controller;
  IjkMediaController jk_controller = IjkMediaController();
  int initial_index;//初始index
  Tease_ds tease;
  bool first_time = true;//判断是否是第一次显示
  ImageVideoViewState(this.w_list,this.initial_index,this.tease)
  {
    controller = PageController();
  }

  //*************************************flutter_ijkplayer相关函数**********************************
  @override
  void dispose() {
    jk_controller?.dispose();
    super.dispose();
  }
  void showIJKDialog() async {
    await jk_controller.setDataSource(
      DataSource.network(
          "http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4"),
    );
    await jk_controller.play();
    await showDialog(
      context: context,
      builder: (_) => _buildIJKPlayer(),
    );
    jk_controller.pause();
  }
  _buildIJKPlayer() {
    return IjkPlayer(
      mediaController: jk_controller,
    );
  }
  //*************************************flutter_ijkplayer相关函数**********************************

  void move_to_initial_index()
  {
    if(controller.hasClients)
    {
      print("animate to Page----------------------");
      controller.animateToPage(initial_index, curve:Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }
  Widget _swiperBuilder(BuildContext context, int index)
  {
    if(tease.widget_mark[index] == 1)
      {
        return GestureDetector(
          child:w_list[index],
          onTap: (){
            showIJKDialog();
          },
        );
      }
    else
      {
        return Center(
          child: w_list[index],
        );
      }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
        body:Swiper(
          itemCount: w_list.length,
          //itemWidth: MediaQuery.of(context).size.width,
          itemBuilder: _swiperBuilder,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              builder: DotSwiperPaginationBuilder(
                  color: Colors.black54,
                  activeColor: Colors.blue,
              )
          ),
          controller: SwiperController(),
          autoplayDisableOnInteraction: true,
          scrollDirection: Axis.horizontal,
          autoplay: false,
          index: initial_index,
          viewportFraction: 1.0,
          scale: 1.0,
          //layout: SwiperLayout.STACK,
          //onTap: (index) => print('点击了第$index'),
        ),
    ),
    );
  }
}

class Video_chewie
{
  /*
  使用chewie这个flutter库写的视频播放，单独拿出来可以，但后面考虑到Swiper切换报错，所以不会使用这个类
   */
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  void initController(String url)
  {
    videoPlayerController = VideoPlayerController.network(
        url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: !true,
      looping: false,
      showControls: true,
      // 占位图
      placeholder: new Container(
        color: Colors.grey,
      ),
      // 是否在 UI 构建的时候就加载视频
      autoInitialize: true,
      // 拖动条样式颜色
      materialProgressColors: new ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );
  }

  Widget get_video_widget()
  {
    return Center(
      child:Chewie(
        controller: chewieController,
      ),
    );
  }

  void destroy_controller()
  {
    videoPlayerController.dispose();
    chewieController.dispose();
  }

}