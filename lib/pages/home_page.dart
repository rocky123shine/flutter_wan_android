import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wan_android/apollo_service.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/article_entity.dart';
import 'package:flutter_wan_android/entity/banner_entity.dart';
import 'package:flutter_wan_android/http/apollo_utils.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/res/colors.dart';

class HomePage extends StatefulWidget  {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  List<BannerData> bannerDatas = [];
  List<ArticleDataData> articleDatas = [];

  @override
  void initState() {
    super.initState();
    //进来就做网络请求 拉取数据
    _getHttpData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         SliverAppBar(
          pinned: true,
          snap:false,
          floating: false,
          //leading: Icon(Icons.home),
         //actions: const <Widget>[Icon(Icons.search)],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("首页"),
              Icon(Icons.search)
            ],
          ),
          expandedHeight: 180,
           flexibleSpace: FlexibleSpaceBar(
             background: SizedBox(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.width / 1.8 * 0.8,
               child: Swiper(
                 key: UniqueKey(),
                 itemCount: bannerDatas.length,
                 itemBuilder: (BuildContext context, int index) {
                   return Image.network(
                     bannerDatas[index].imagePath,
                     fit: BoxFit.fill,
                   );
                 },
                 autoplay: true,
                 autoplayDelay: 3000,
                 //触发时是否停止播放
                 autoplayDisableOnInteraction: true,
                 duration: 600,
                 //默认分页按钮
                 // control: const SwiperControl(),
                 //默认指示器
                 pagination: const SwiperPagination(
                   // SwiperPagination.fraction 数字1/5，默认点
                   builder: DotSwiperPaginationBuilder(
                       size: 6,
                       activeSize: 8,
                       activeColor: Colors.red,
                       color: Colors.grey),
                 ),

                 //视图宽度，即显示的item的宽度屏占比,
                 // viewportFraction: 0.8,
                 //两侧item的缩放比
                 // scale: 0.9,

                 onTap: (int index) {
                   //点击事件，返回下标
                   print("index-----" + index.toString());
                 },
               ),
             ),
           ),
         ),
         SliverList(
           delegate: SliverChildBuilderDelegate(
               (context,index){
                 return _getRow(index);
               },
             childCount: articleDatas.length
           ),
         ),
        ],
      ),
    );
  }

  void _getHttpData() async {
    try {
      var bannerJson = await HttpUtils.instance.get(Api.BANNER);
      var bannerMap = json.decode(bannerJson.toString());
      var bannerEntity = BannerEntity.fromJson(bannerMap);
      //article
      var articleResponse = await HttpUtils.instance.get(Api.ARTICLE_LIST);
      var articleMap = json.decode(articleResponse.toString());
      var articleEntity = ArticleEntity.fromJson(articleMap);

      setState(() {
        if (bannerEntity.data != null) bannerDatas = bannerEntity.data!;
        if (articleEntity.data != null && articleEntity.data!.datas != null) {
          articleDatas = articleEntity.data!.datas!;
        }
      });

      //ApolloUtils.instance.query(ApolloService.AAA);

    } catch (e) {
      print(e);
    }
  }

  _getRow(int index) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          child: ListTile(
            title: Text(articleDatas[index].title ?? ""),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: <Widget>[
                    Text(articleDatas[index].superChapterName ?? "",
                        style: const TextStyle(color: YColors.colorAccent)),
                    Text("      " + (articleDatas[index].author ?? "")),
                  ],
                ),
                Text("${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).year}" +
                    "-${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).month}" +
                    "-${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).day}" +
                    "  ${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).hour}:${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).minute}:${DateTime.fromMillisecondsSinceEpoch(articleDatas[index].publishTime ?? 0).second}"),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        print('dianji 了 index---------');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
