import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/navi_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/pages/web.dart';
import 'package:flutter_wan_android/res/colors.dart';

class NaviPage extends StatefulWidget {
  const NaviPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NaviPageState();
  }
}

class _NaviPageState extends State<NaviPage>
    with AutomaticKeepAliveClientMixin {
  List<NaviData>? _datas = []; //一级分类集合
  List<NaviDataArticle>? articles = []; //二级分类集合
  int index = 0; //一级分类下标

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      var response = await HttpUtils.instance.get(Api.NAVI);
      var userMap = json.decode(response.toString());
      var naviEntity = NaviEntity.fromJson(userMap);

      /// 初始化
      setState(() {
        _datas = naviEntity.data;
        index = 0;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(
              color: YColors.color_fff,
              child: ListView.builder(
                  itemCount: _datas!.length,
                  itemBuilder: (BuildContext context, int position) {
                    return getRow(position);
                  }),
            )),
        Expanded(
          flex: 5,
          child: ListView(
            children: <Widget>[
              Container(
                //height: double.infinity,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                color: YColors.color_F9F9F9,
                child: getChip(index), //传入一级分类下标
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color textColor = YColors.colorPrimary; //字体颜色

  Widget getRow(int i) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        color: index == i ? YColors.color_F9F9F9 : Colors.white,
        child: Text(_datas![i].name ?? "",
            style: TextStyle(
                color: index == i ? textColor : YColors.color_666,
                fontWeight: index == i ? FontWeight.w600 : FontWeight.w400,
                fontSize: 16)),
      ),
      onTap: () {
        setState(() {
          index = i; //记录选中的下标
          textColor = YColors.colorPrimary;
        });
      },
    );
  }

  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        articles!.length,
        (int index) {
          return ActionChip(
            //标签文字
            label: Text(articles?[index].title ?? "",
                style: const TextStyle(fontSize: 16, color: YColors.color_666)),
            //点击事件
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebPage(
                       articles?[index].link??"",title:articles?[index].title??"",),
                ),
              );
            },
            elevation: 3,
            backgroundColor: Colors.grey.shade200,
          );
        },
      ).toList(),
    );
  }

  ///
  /// 根据一级分类下标更新二级分类集合
  ///
  List<NaviDataArticle>? _updateArticles(int i) {
    setState(() {
      if (_datas!.length != 0) articles = _datas![i].articles;
    });
    return articles;
  }

  @override
  bool get wantKeepAlive => true;
}
