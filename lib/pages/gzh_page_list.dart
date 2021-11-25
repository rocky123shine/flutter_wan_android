import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:flutter_wan_android/animi/slide_route.dart';
import 'package:flutter_wan_android/entity/gzh_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/pages/web.dart';
import 'package:flutter_wan_android/res/colors.dart';

class GzhPageList extends StatefulWidget {
  var cid = 0;

  GzhPageList(this.cid, {Key? key}) : super(key: key);

  @override
  State<GzhPageList> createState() => GzhPageListState(cid);
}

class GzhPageListState extends State<GzhPageList>
    with AutomaticKeepAliveClientMixin {
  List<Articals>? datas = [];
  var cid = 0;

  GzhPageListState(this.cid);

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: datas?.length ?? 0,
            itemBuilder: (context, index) => _getRow(index)),
      );

  _getRow(int index) {
    var detail = datas?[index];
    if (detail == null) return const Text("暂无相关数据");

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideRightRoute(
            WebPage(
              detail.link ?? "",
              title: detail.title,
            ),
          ),
        );
      },
      child: Card(
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
                    Text(
                      detail.superChapterName ?? "",
                      style: const TextStyle(
                          color: YColors.colorPrimary, fontSize: 12),
                    ),
                    const Text("  "),
                    Text(
                      detail.chapterName ?? "",
                      style: const TextStyle(
                          color: YColors.secondaryText, fontSize: 12),
                    ),
                  ],
                ),
                const Icon(
                  Icons.favorite_outlined,
                  color: YColors.color_999,
                ),
              ]),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                child: HtmlRichText(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  htmlText: detail.title ?? "",
                  golobalTextStyle: const TextStyle(
                      color: YColors.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
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
                  Text("${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).year}" +
                      "-${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).month}" +
                      "-${DateTime.fromMillisecondsSinceEpoch(detail.publishTime ?? 0).day}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDetail() async {
    var path = "wxarticle/list/$cid/1/json";
    var resJson = await HttpUtils.instance.get(path);
    var articalEntity = ArticalEntity.fromJson(json.decode(resJson.toString()));
    setState(() {
      datas = articalEntity.data?.datas ??= [];
    });
  }

  @override
  bool get wantKeepAlive => true;
}
