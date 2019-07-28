import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';    // 引入头文件


class Screnn_size {
  static double width;
  static double  height;
}


class Article
{
  String imge_url;
  String text;
  Article({this.imge_url,this.text});
}
class SwiperView extends StatefulWidget {
  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  // 声明一个list，存放image Widget
  List<Widget> swpierList = List();
  @override
  void initState() {
    swpierList
     ..add(getArticleWidget(Article(
      imge_url: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2829014450,3677490423&fm=27&gp=0.jpg',
      text: "如何实现心灵自愈?",
    )))
      ..add(getArticleWidget(Article(
        imge_url:'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2829014450,3677490423&fm=27&gp=0.jpg',
        text: "如何实现心灵自愈?",
      )))
      ..add(getArticleWidget(Article(
        imge_url: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2829014450,3677490423&fm=27&gp=0.jpg',
        text: "如何实现心灵自愈?",
      )))
      ..add(getArticleWidget(Article(
        imge_url: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2829014450,3677490423&fm=27&gp=0.jpg',
        text: "如何实现心灵自愈?",
      )));
    super.initState();
  }

  Widget getArticleWidget(Article article)
  {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              //color: Colors.red,
              image: DecorationImage(image: new NetworkImage(article.imge_url),fit: BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
        ),
        Container(
            child: Center(child: Text(article.text,style: TextStyle(fontSize: 20,color: Colors.black38),),)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    Screnn_size.width = MediaQuery.of(context).size.width;
    Screnn_size.height = MediaQuery.of(context).size.height;
    return InitimateSwiperView();
  }

  Widget InitimateSwiperView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      width: MediaQuery.of(context).size.width,
      height: Screnn_size.height/4*1.2,
      child: Swiper(
        itemCount: 4,
        itemBuilder: _swiperBuilder,
        scale: 0.9,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54,
                activeColor: Colors.white
            )
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index'),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return Container
      (
      child: swpierList[index],
      decoration: BoxDecoration(
        //color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
    );
  }
}