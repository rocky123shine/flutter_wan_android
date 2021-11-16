import 'package:flutter/material.dart';
import 'package:flutter_wan_android/pages/home_page.dart';
import 'package:flutter_wan_android/pages/navi_page.dart';
import 'package:flutter_wan_android/pages/project_page.dart';
import 'package:flutter_wan_android/pages/tree_page.dart';
import 'package:flutter_wan_android/res/colors.dart';
import 'package:flutter_wan_android/res/strings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: YStrings.appName,
      theme: ThemeData(
        primaryColor: YColors.colorPrimary,
        primaryColorDark: YColors.colorPrimaryDark,
        dividerColor: YColors.dividerColor,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: YColors.colorAccent),
      ),
      home: MyHomePage(title: YStrings.appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var pages = <Widget>[
  const HomePage(),
  const TreePage(),
  const NaviPage(),
  const ProjectPage(),
];

class _MyHomePageState extends State<MyHomePage> {
  int _sellectedIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          onPageChanged: _pageSelectedChange,
          itemCount: pages.length,
         physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              pages.elementAt(index)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _bottomItemChange,
        items: _createBottomItem(),
        currentIndex: _sellectedIndex,
        //当前选中下标
        type: BottomNavigationBarType.fixed,
        //显示模式
        fixedColor: YColors.colorPrimary,
      ),
    );
  }

  _pageSelectedChange(int index) {
    setState(() {
      _sellectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _createBottomItem() {
    List<BottomNavigationBarItem> list = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: YStrings.home),
      BottomNavigationBarItem(
          icon: const Icon(Icons.filter_list), label: YStrings.tree),
      BottomNavigationBarItem(
          icon: const Icon(Icons.low_priority), label: YStrings.navi),
      BottomNavigationBarItem(
          icon: const Icon(Icons.apps), label: YStrings.project),
    ];

    return list;
  }

  void _bottomItemChange(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.ease);
  }
}
