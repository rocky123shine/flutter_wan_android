import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/http/http_utils.dart';
import 'package:flutter_wan_android/res/colors.dart';
import 'package:image_picker/image_picker.dart';

class PersonInfoPage extends StatefulWidget {
  const PersonInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonInfoPage> createState() => PersonInfoPageState();
}

class PersonInfoPageState extends State<PersonInfoPage> {
  final ImagePicker _pick = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) => MaterialApp(
        routes: {
          "/": (_) {
            Rect _buildRect() {
              final topPadding = MediaQueryData.fromWindow(window).padding.top;
              final top = topPadding;
              var height = MediaQueryData.fromWindow(window).size.height - top;
              //height -= 56.0 + MediaQueryData.fromWindow(window).padding.bottom;
              height -= MediaQueryData.fromWindow(window).padding.bottom;
              if (height < 0.0) {
                height = 0.0;
              }
              return Rect.fromLTWH(0.0, top,
                  MediaQueryData.fromWindow(window).size.width, height);
            }

            var rect = _buildRect();
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 96,
                    padding: EdgeInsets.only(top: rect.top),
                    color: Theme.of(context).colorScheme.primary,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: YColors.color_fff,
                              )),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Center(
                                child: Text(
                                  "个人信息",
                                  style: TextStyle(
                                    color: YColors.color_fff,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 0),
                    color: YColors.color_fff,
                    height: 88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "头像",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                _selectPic(context);
                              },
                              child: Container(
                                width: 66,
                                height: 66,
                                margin: const EdgeInsets.only(right: 16),
                                child: CircleAvatar(
                                  backgroundImage: null == _image
                                      ? const NetworkImage(
                                          "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg")
                                      : FileImage(_image!) as ImageProvider,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 28,
                              color: YColors.dividerColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    color: YColors.color_fff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "名字",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text("名字"),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 28,
                              color: YColors.dividerColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    color: YColors.color_fff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "个人签名",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text("个签"),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 28,
                              color: YColors.dividerColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    color: YColors.color_fff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "性别",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text("性别"),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 28,
                              color: YColors.dividerColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    color: YColors.color_fff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "年龄",
                          style: TextStyle(
                            color: YColors.primaryText,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text("年龄"),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 28,
                              color: YColors.dividerColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            );
          }
        },
      );

  void _selectPic(BuildContext context) async {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              title: const Text("选择图片"),
              message: const Text("选择图片的方式"),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                  child: const Text("拍照"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    _selectPhoto();
                  },
                  child: const Text("相册"),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("取消"),
                isDefaultAction: true,
              ),
            ));
  }

  void _takePhoto() async {
    // if (await Permission.camera.request().isGranted &&
    //     await Permission.storage.request().isGranted) {
    var image = await _pick.pickImage(
        source: ImageSource.camera, maxWidth: 150, maxHeight: 150);
    setState(() {
      _image = File(image?.path ?? "");
    });
    // } else {
    //
    // }
  }

  void _selectPhoto() async {
    // if (await Permission.storage.request().isGranted) {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 150, maxHeight: 150);
    setState(() {
      _image = File(image?.path ?? "");
    });
    // } else {
    //   await Permission.storage.request();
    // }
  }

  void _uploadPhoto(File _imagePath) async {
    var path = _imagePath.path;
    FormData formData = FormData.fromMap({
      "pathName":path.split('/').last,
      "file":await MultipartFile.fromFile(path,filename: "head.jpg")
    });

    var res = await HttpUtils.instance.post("",data: formData);
    //......

  }
}
