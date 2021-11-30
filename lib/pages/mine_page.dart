import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/pages/person_info_page.dart';
import 'package:flutter_wan_android/res/colors.dart';

class MinetPage extends StatelessWidget {
  const MinetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonInfoPage(),
                  ),
                );
              },
              child: const Icon(Icons.settings),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).accentColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: const [
                    Icon(
                      Icons.person_rounded,
                      size: 80,
                      color: YColors.color_fff,
                    ),
                    Text(
                      "未登录",
                      style: TextStyle(color: YColors.color_fff, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            color: YColors.color_fff,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).accentColor,
                      size: 28,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "我的收藏",
                        style: TextStyle(
                          color: YColors.primaryText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 28,
                  color: YColors.dividerColor,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            color: YColors.color_fff,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.web_asset,
                      color: Theme.of(context).accentColor,
                      size: 28,
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "收藏网站",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 28,
                  color: YColors.dividerColor,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            color: YColors.color_fff,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.code,
                      color: Theme.of(context).accentColor,
                      size: 28,
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "学习入口",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 28,
                  color: YColors.dividerColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
