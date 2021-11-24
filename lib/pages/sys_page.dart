import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:flutter_wan_android/common/api.dart';
import 'package:flutter_wan_android/entity/tree_entity.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SysPage extends StatefulWidget {
  const SysPage({Key? key}) : super(key: key);

  @override
  State<SysPage> createState() => SysPageState();
}

class SysPageState extends State<SysPage> with AutomaticKeepAliveClientMixin {
  List<TreeData>? _data;

  @override
  void initState() {
    super.initState();
    _getHttp();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
            itemCount: _data == null ? 0 : _data!.length,
            itemBuilder: (context, index) {
              return StickyHeader(
                header: Container(
                  //header组件
                  height: 50.0,
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _data == null ? "" : _data![index].name ?? "",
                    style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.bold ),
                  ),
                ),
                content: Container(
                  margin: const EdgeInsets.only(top: 16.0, left: 10, right: 10,bottom: 16),
                  //内容组件
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _itemWidgetList(index),
                  ),
                ),
              );
            }),
      );

  void _getHttp() async {
    var response = await HttpUtils.instance.get(Api.TREE);
    var responseMap = json.decode(response.toString());
    var treeEntity = TreeEntity.fromJson(responseMap);
    setState(() {
      _data = treeEntity.data;
    });
  }

  List<Widget> _itemWidgetList(int index) {
    List<Widget> list = [];
    if (_data == null || _data![index].children == null) {
      list.add(const Text("本组数据为空"));
    } else {
      var children = _data![index].children!;
      for (int i = 0; i < children.length; i++) {
        list.add(
          InkWell(
            onTap: (){},
            child: TextTagWidget(
              "${children[i].name}",
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            ),
          )
        );
      }
    }
    return list;
  }

  @override
  bool get wantKeepAlive => true;
}
