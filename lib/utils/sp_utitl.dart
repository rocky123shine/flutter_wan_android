import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences中为我们提供了String、bool、Double、Int、StringList数据类型的存取。
class SpUtils {
  static SpUtils? _utils;

  SharedPreferences? _sp;

  SpUtils._() {
    _sp = _initSp();
  }

  static get instance => getInstance();

  static getInstance() {
    _utils ??= SpUtils._();
    return _utils;
  }

  _initSp() async {
    return await SharedPreferences.getInstance();
  }

  putString(String K, String V) async {
    _sp!.setString(K, V);
  }

  putBool(String K, bool V) async {
    _sp!.setBool(K, V);
  }

  putDouble(String K, double V) async {
    _sp!.setDouble(K, V);
  }

  putInt(String K, int V) async {
    _sp!.setInt(K, V);
  }

  putStringList(String K, List<String> V) {
    _sp!.setStringList(K, V);
  }

  getValue(String K) {
    return _sp!.get(K);
  }
}
