import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/gzh_entity.dart';
import 'package:flutter_wan_android/entity/project_entity.dart';
import 'package:flutter_wan_android/entity/project_list_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/res/colors.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  var tabLength = 0;
  List<ProjectData> _datas = []; //tab集合
  List<ProjectListDataData> _listDatas = []; //内容集合
  var id = 0;
  var pageNum = 1;
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    getHttpData();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _datas.length,
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
              tabs: _datas
                  .map((e) => SizedBox(
                        child: HtmlRichText(htmlText: e.name ?? ""),
                        height: 30,
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: _datas.map((e) {
              return EasyRefresh(
                  controller: _controller,
                  enableControlFinishLoad: true,
                  enableControlFinishRefresh: true,
                  onRefresh: () async {
                    setState(() {
                      pageNum = 1;
                    });
                    getDetail();
                  },
                  onLoad: () async {
                    setState(() {
                      pageNum++;
                    });
                    getDetail();
                  },
                  child: ListView.builder(
                      itemCount: _listDatas.length,
                      itemBuilder: (context, index) => _getRow(index)));
            }).toList(),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;

  void getHttpData() async {
    var jsonRes = await HttpUtils.instance.get(Api.PROJECT);
    var projMap = json.decode(jsonRes.toString());
    var projEntity = ProjectEntity.fromJson(projMap);

    setState(() {
      _datas = projEntity.data ??= [];
      tabLength = _datas.length;
      id = _datas[0].id ??= 0;
    });
    getDetail();

    _tabController = TabController(length: tabLength, vsync: this)
      ..addListener(() {
        var index = _tabController?.index ?? 0;
        pageNum = 1;
        id = _datas[index].id ?? 0;
        getDetail();
      });
  }

  void getDetail() async {
    var path = "/project/list/$pageNum/json";
    var resJson = await HttpUtils.instance.get(path, data: {"cid": id});
    var projectListEntity =
        ProjectListEntity.fromJson(json.decode(resJson.toString()));

    setState(() {
      if (pageNum > 1) {
        if (projectListEntity.data == null ||
            projectListEntity.data!.size == 0) {
          pageNum--;
          _controller.finishLoad(success: true, noMore: true);
        } else {
          _controller.finishLoad(success: true, noMore: false);
        }
        _listDatas.addAll(projectListEntity.data == null
            ? []
            : projectListEntity.data!.datas ?? []);
      } else {
        _controller.finishRefresh(success: true);

        _listDatas = projectListEntity.data == null
            ? []
            : projectListEntity.data!.datas ?? [];
      }
    });
  }

  _getRow(int index) {
    var detail = _listDatas[index];
    if (null == detail) {
      return const Text("暂无相关数据");
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shadowColor: YColors.bg,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "项目",
                    style: TextStyle(color: YColors.colorPrimary, fontSize: 12),
                  ),
                  const Text("  "),
                  Text(
                    detail.author ?? "",
                    style: const TextStyle(
                        color: YColors.secondaryText, fontSize: 12),
                  ),
                ],
              ),
              Text("${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).year}" +
                  "-${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).month}" +
                  "-${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).day}"),
            ]),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              margin: const EdgeInsets.all(0),
              child: Row(children: [
                Image(
                  image: NetworkImage(detail.envelopePic ?? ""),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                Flexible(
                  //  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Text(
                      detail.title ?? "",
                      style: const TextStyle(
                          color: YColors.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      detail.superChapterName ?? "",
                      style: const TextStyle(
                          color: YColors.primaryText, fontSize: 14),
                    ),
                    const Text("  "),
                    Text(
                      detail.chapterName ?? "",
                      style: const TextStyle(
                          color: YColors.secondaryText, fontSize: 14),
                    ),
                  ],
                ),
                const Icon(
                  Icons.favorite_outlined,
                  color: YColors.color_999,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
