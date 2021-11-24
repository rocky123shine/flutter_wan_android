import 'package:flutter/material.dart';
import 'package:flutter_wan_android/pages/sys_page.dart';
import 'package:flutter_wan_android/res/colors.dart';
import 'package:flutter_wan_android/res/strings.dart';

import 'navi_page.dart';

class TreePage extends StatefulWidget {
  const TreePage({Key? key}) : super(key: key);

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _controller;
  var currentPos = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() => {
          setState(() {
            currentPos = _controller.index;
          })
        });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: TabBar(
              controller: _controller,
              labelColor: YColors.color_fff,
              //选中的颜色
              labelStyle: const TextStyle(fontSize: 18),
              //选中的样式
              unselectedLabelColor: YColors.primaryText,
              //未选中的颜色
              unselectedLabelStyle: const TextStyle(fontSize: 16),
              //未选中的样式
              indicatorColor: YColors.color_fff,
              //下划线颜色
              isScrollable: true,
              //是否可滑动
              tabs: [
                Tab(
                  height: 40,
                  text: YStrings.tree,
                ),
                Tab(
                  height: 40,
                  text: YStrings.navi,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: pages,
        ),
      );

  @override
  bool get wantKeepAlive => true;
  var pages = <Widget>[const SysPage(), const NaviPage()];
}
