/*
本代码描述的数据结构对应的是一个问题所有滚动屏回复中一个回复文章的数据结构
 */
class Scroll_reply_ds
{
  String head_url;//头像url
  String user_name;//用户名
  String time;//回答时间,根据后端传来的时间id进行加工构造成2019-2-2的形式
  String id;//标识符。也是时间和time不同，time是后端传来的id时间加工形成“2019-9-23”这种形式显示的时间
  String identity;//身份
  int commentNum;//评论数
  int upNum;//点赞数
  List<String> img_urls;//回复文章中几个图片url，小于等于三张
  String head_text;//文章回复开头的一些文字
  Scroll_reply_ds({
   this.time,this.user_name,this.commentNum,this.id,this.upNum,this.head_text,this.identity,this.head_url,this.img_urls
});
}

List<Scroll_reply_ds> scroll_reply_articles_example =
    [
      Scroll_reply_ds(
          head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
          user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
          img_urls: [
          ],
          head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
          commentNum: 5,
          id: "2019_08_17_19_48_05",
          upNum: 6
      ),
      Scroll_reply_ds(
          head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
          user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
          img_urls: [
            "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg",
            "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg"
          ],
          head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
          commentNum: 5,
          upNum: 6,
          id: "2019_08_17_19_48_05",
      ),
      Scroll_reply_ds(
        head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
      user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
      img_urls: [
        "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg"
      ],
      head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
        commentNum: 5,
        upNum: 6
      ),
      Scroll_reply_ds(
        head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
        user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
        img_urls: [
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg"
        ],
        head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
          commentNum: 5,
          upNum: 6
      ),
      Scroll_reply_ds(
        head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
        user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
        img_urls: [
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg",
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg",
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg"
        ],
        head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
          commentNum: 5,
          upNum: 6
      ),
      Scroll_reply_ds(
        head_url: "https://pic4.zhimg.com/50/v2-9a3cb5d5ee4339b8cf4470ece18d404f_s.jpg",
        user_name: "小明",time: "2019-9-78",identity: "中国地质大学信息工程学院教授",
        img_urls: [
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg",
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1677427933,3025107141&fm=27&gp=0.jpg"
        ],
        head_text: "我的手机系统是安卓。无意间发现自己的屏幕被人监控，请问怎样才能彻底摆脱被监控的处境呢",
          commentNum: 5,
          upNum: 6
      ),
    ];
