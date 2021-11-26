import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  static DbUtils? _utils;

//构建数据库对象
  Database? database;

  DbUtils._() {
    _initDB();
  }

  static get instance => getInstance();

  static getInstance() {
    _utils ??= DbUtils._();
    return _utils;
  }

  void _initDB() async {
    //获取应用文件目录类似于Ios的NSDocumentDirectory和Android上的 AppData目录
    final fileDirectory = await getApplicationDocumentsDirectory();
    //获取存储路径
    final dbPath = fileDirectory.path;
    database = await openDatabase(dbPath + "/wan_android.db", version: 1,
        onCreate: (Database db, int version) async {
      /// 在这里可以初始化表
      //await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT)");
    });
  }
}
