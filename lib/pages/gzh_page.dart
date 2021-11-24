import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/gzh_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/pages/gzh_page_list.dart';
import 'package:flutter_wan_android/res/colors.dart';

class GzhPage extends StatefulWidget {
  const GzhPage({Key? key}) : super(key: key);

  @override
  State<GzhPage> createState() => GzhPageState();
}

class GzhPageState extends State<GzhPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  var tabLength = 0;
  List<Author>? gzhAuthors = [];
  List<Articals>? datas = [];
  var id = 0;
  var pageNum = 1;

  @override
  void initState() {
    super.initState();
    getHttpData();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: gzhAuthors!.length,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              isScrollable: true,
              labelColor: YColors.color_fff,
              //选中的颜色
              labelStyle: const TextStyle(fontSize: 18),
              //选中的样式
              unselectedLabelColor: YColors.primaryText,
              //未选中的颜色
              unselectedLabelStyle: const TextStyle(fontSize: 16),
              //未选中的样式
              indicatorColor: YColors.color_fff,
              // labelPadding:EdgeInsets.all(8),
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: gzhAuthors!
                  .map((e) => SizedBox(
                        child: Text(e.name ?? ""),
                        height: 30,
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            // children: gzhAuthors!
            //     .map((e) => ListView.builder(
            //         itemCount: datas?.length ?? 0,
            //         itemBuilder: (context, index) => _getRow(index)))
            //     .toList(),
            children: gzhAuthors!.map((e) => GzhPageList(e.id??0)).toList(),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;

  void getHttpData() async {
    var jsonRes = await HttpUtils.instance.get(Api.GZH);
    var gzhMap = json.decode(jsonRes.toString());
    var gzhEntity = GzhAuthorEntity.fromJson(gzhMap);

    setState(() {
      gzhAuthors = gzhEntity.data ??= [];
      tabLength = gzhAuthors!.length;
      id = gzhAuthors?[0].id ?? 0;
      pageView(gzhAuthors?.length??0);
    });

    _tabController = TabController(length: tabLength, vsync: this)
      ..addListener(() {
        var index = _tabController?.index ?? 0;
        id = gzhAuthors?[index].id ?? 0;
      });
  }

  var pageViews = <Widget>[];

  pageView(int tabLength) {
    if (pageViews.length != tabLength) {
      pageViews.clear();
      for (int i = 0; i < tabLength; i++) {
        pageViews.add(GzhPageList(gzhAuthors![i].id??0));
      }
    }
    return pageViews;
  }
}
