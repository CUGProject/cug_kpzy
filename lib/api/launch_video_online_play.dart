import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';

/*
通过修改video_url来实现在线播放某个视频
 */
String video_url_global = "http://www.cugkpzy.com/get_tucao_video/kkk.mp4";
VideoPlayerController videoPlayerController = VideoPlayerController.network(
    video_url_global);

final chewieController = ChewieController(
  videoPlayerController: videoPlayerController,
  aspectRatio: 1,
  autoPlay: true,
  looping: true,
);

final playerWidget = Chewie(
  controller: chewieController,
);

class VidoPlayChewie extends StatefulWidget{
  String video_url;
  VidoPlayChewie({this.video_url});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoState(video_url: video_url);
  }
}
class _VideoState extends State{
  String video_url;
  _VideoState({this.video_url}){
    video_url_global = video_url;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return playerWidget;
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
