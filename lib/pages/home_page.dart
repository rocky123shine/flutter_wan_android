import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/banner_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerData> bannerDatas = [];

  @override
  void initState() {
    super.initState();
    //进来就做网络请求 拉取数据
    _getHttpData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
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
      ]),
    );
  }

  void _getHttpData() async {
    var bannerJson = await HttpUtils.instance.get(Api.BANNER);
    var bannerMap = json.decode(bannerJson.toString());
    var bannerEntity = BannerEntity.fromJson(bannerMap);
    setState(() {
      if (bannerEntity.data != null) bannerDatas = bannerEntity.data!;
    });
  }
}
