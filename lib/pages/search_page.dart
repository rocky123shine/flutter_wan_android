import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/common/common_var.dart';
import 'package:flutter_wan_android/entity/article_entity.dart';
import 'package:flutter_wan_android/entity/hot_search_entity.dart';
import 'package:flutter_wan_android/entity/search_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/pages/web.dart';
import 'package:flutter_wan_android/res/colors.dart';
import 'package:flutter_wan_android/utils/sp_utitl.dart';

class SearchPage extends StatefulWidget {
  String? keyWords = "";

  SearchPage({this.keyWords, Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  var editWidgetNull = true; //显示历史记录
  var pageNum = 1;
  late EasyRefreshController refreshController;
  List<ArticleDataData> datas = [];
  List<HotSearchData> hotSearchDatas = [];
  late TextEditingController _searchController;
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    editWidgetNull = (widget.keyWords == "keyWords");
    refreshController = EasyRefreshController();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length));
    });
    _getHttp();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: YColors.color_fff,
                      size: 28,
                    ),
                  ),
                  Flexible(
                    child: _getTitleWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: editWidgetNull ? _getRecord() : _getSearchContent(),
      );

  _getTitleWidget() {
    if (widget.keyWords == "keyWords") {
      //search 需要显示搜索框 和搜索按钮
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            InkWell(
              onTap: () {
                if (!history.contains(_searchController.text)) {
                  while (history.length >= 10) {
                    history.removeLast();
                  }
                  history.insert(0, _searchController.text);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(
                      keyWords: _searchController.text,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 28,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 152,
              height: 34,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  // 对其 微调TextStyle的height 和 contentPadding
                  style: const TextStyle(
                      height: 1.4, fontSize: 14, color: YColors.color_fff),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: YColors.color_fff),
                    counterText: "",
                    //contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    fillColor: YColors.color_fff,
                    hintText: "请输入关键词",
                    //suffixIcon: Icon(Icons.close),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: YColors.color_fff),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: YColors.color_fff),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: YColors.color_fff),
                    ),
                    suffix: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: YColors.color_fff,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _searchController.clear();
                      },
                    ),
                  ),
                  cursorColor: YColors.color_fff,
                  cursorWidth: 2,
                  // 绑定控制器
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  // 输入改变以后的事件
                  onChanged: (value) {
                    setState(() {
                      _searchController.text = value;
                    });
                  },
                  onSubmitted: (v) {
                    if (!history.contains(v)) {
                      while (history.length >= 10) {
                        history.removeLast();
                      }
                      history.insert(0, v);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          keyWords: v,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 44),
        child: Center(
          child: Text(
            widget.keyWords ?? "",
            style: const TextStyle(
              color: YColors.color_fff,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }

  _getSearchContent() {
    return EasyRefresh(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        controller: refreshController,
        onLoad: () async {
          setState(() {
            pageNum++;
          });
        },
        onRefresh: () async {
          setState(() {
            pageNum = 1;
          });
        },
        child: ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) => _getSearchRow(index)));
  }

  _getRecord() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "历史记录",
                style: TextStyle(
                    color: YColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
              child: Wrap(
                children: history
                    .map((e) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                          keyWords: e,
                                        )));
                          },
                          child: TextTagWidget(
                            e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Row(
            children: const [
              Text(
                "热门搜索",
                style: TextStyle(
                    color: YColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
              child: Wrap(
                children: _itemWidgetList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    if (hotSearchDatas.isEmpty) {
      list.add(const Text("热搜词未设置"));
    } else {
      var children = hotSearchDatas;
      for (int i = 0; i < children.length; i++) {
        list.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(
                          keyWords: "${children[i].name}",
                        )));
          },
          child: TextTagWidget(
            "${children[i].name}",
          ),
        ));
      }
    }
    return list;
  }

  _getSearchRow(int index) {
    if (datas.isEmpty) return const Text("暂无数据");

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          child: ListTile(
            title: HtmlRichText(
              htmlText: datas[index].title ?? "",
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: <Widget>[
                    Text(datas[index].superChapterName ?? "",
                        style: const TextStyle(color: YColors.colorAccent)),
                    Text("      " + (datas[index].author ?? "")),
                  ],
                ),
                Text("${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).year}" +
                    "-${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).month}" +
                    "-${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).day}" +
                    "  ${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).hour}:${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).minute}:${DateTime.fromMillisecondsSinceEpoch(datas[index].publishTime ?? 0).second}"),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebPage(
                      datas[index].link ?? "",
                      title: datas[index].title,
                    )));
      },
    );
  }

  void _getHttp() async {
    if (widget.keyWords == "keyWords" && editWidgetNull) {
      //这个是 首页搜索进来 并且输入框没有数据
      //展示历史记录
      var res = await HttpUtils.instance.get(Api.GET_HOT_SEARCH);
      var map = json.decode(res.toString());
      var entity = HotSearchEntity.fromJson(map);
      var historyList =
          await SpUtils.instance.getStringList(CommonVar.SEARCH_GISTORY);
      setState(() {
        hotSearchDatas = entity.data ?? [];
        history = historyList;
      });
    } else {
      //查询数据
      var path = "article/query/${pageNum - 1}/json";
      var res = await HttpUtils.instance
          .post(path, data: {"k": widget.keyWords ?? ""});
      var map = json.decode(res.toString());
      var searchEntity = SearchEntity.fromJson(map);
      setState(() {
        refreshController.finishRefresh(success: true);
        refreshController.finishLoad(success: true);
        datas = searchEntity.data?.datas ?? [];
      });
    }
  }

  @override
  void deactivate() {
    SpUtils.instance.putStringList(CommonVar.SEARCH_GISTORY, history);

    super.deactivate();
  }
}
