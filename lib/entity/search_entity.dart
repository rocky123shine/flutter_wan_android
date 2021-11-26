import 'article_entity.dart';

class SearchEntity {
  SearchData? data;
  int? errorCode;
  String? errorMsg;

  SearchEntity({this.data, this.errorCode, this.errorMsg});

  SearchEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
  }
}

class SearchData {
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;
  List<ArticleDataData>? datas;

  SearchData(
      {this.over,
      this.pageCount,
      this.total,
      this.curPage,
      this.offset,
      this.size,
      this.datas});

  SearchData.fromJson(Map<String, dynamic> json) {
    over = json['over'];
    pageCount = json['pageCount'];
    total = json['total'];
    curPage = json['curPage'];
    offset = json['offset'];
    size = json['size'];
    if (json['datas'] != null) {
      datas = <ArticleDataData>[];
      for (var v in (json['datas'] as List)) {
        datas!.add(ArticleDataData.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['over'] = over;
    data['pageCount'] = pageCount;
    data['total'] = total;
    data['curPage'] = curPage;
    data['offset'] = offset;
    data['size'] = size;
    if (datas != null) {
      data['datas'] = datas?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
