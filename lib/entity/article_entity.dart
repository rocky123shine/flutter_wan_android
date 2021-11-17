class ArticleEntity {
  ArticleData? data;
  int? errorCode;
  String? errorMsg;

  ArticleEntity({this.data, this.errorCode, this.errorMsg});

  ArticleEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ArticleData.fromJson(json['data']) : null;
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

class ArticleData {
  bool? over;
  int? pageCount;
  int? total;
  int? curPage;
  int? offset;
  int? size;
  List<ArticleDataData>? datas;

  ArticleData(
      {this.over,
      this.pageCount,
      this.total,
      this.curPage,
      this.offset,
      this.size,
      this.datas});

  ArticleData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class ArticleDataData {
  String? superChapterName;
  int? publishTime;
  int? visible;
  String? niceDate;
  String? projectLink;
  String? author;
  String? prefix;
  int? zan;
  String? origin;
  String? chapterName;
  String? link;
  String? title;
  int? type;
  int? userId;
  List<void>? tags;
  String? apkLink;
  String? envelopePic;
  int? chapterId;
  int? superChapterId;
  int? id;
  bool? fresh;
  bool? collect;
  int ?courseId;
  String? desc;

  ArticleDataData(
      {this.superChapterName,
      this.publishTime,
      this.visible,
      this.niceDate,
      this.projectLink,
      this.author,
      this.prefix,
      this.zan,
      this.origin,
      this.chapterName,
      this.link,
      this.title,
      this.type,
      this.userId,
      this.tags,
      this.apkLink,
      this.envelopePic,
      this.chapterId,
      this.superChapterId,
      this.id,
      this.fresh,
      this.collect,
      this.courseId,
      this.desc});

  ArticleDataData.fromJson(Map<String, dynamic> json) {
    superChapterName = json['superChapterName'];
    publishTime = json['publishTime'];
    visible = json['visible'];
    niceDate = json['niceDate'];
    projectLink = json['projectLink'];
    author = json['author'];
    prefix = json['prefix'];
    zan = json['zan'];
    origin = json['origin'];
    chapterName = json['chapterName'];
    link = json['link'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    if (json['tags'] != null) {
      tags = <Null>[];
    }
    apkLink = json['apkLink'];
    envelopePic = json['envelopePic'];
    chapterId = json['chapterId'];
    superChapterId = json['superChapterId'];
    id = json['id'];
    fresh = json['fresh'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['superChapterName'] = superChapterName;
    data['publishTime'] = publishTime;
    data['visible'] = visible;
    data['niceDate'] = niceDate;
    data['projectLink'] = projectLink;
    data['author'] = author;
    data['prefix'] = prefix;
    data['zan'] = zan;
    data['origin'] = origin;
    data['chapterName'] = chapterName;
    data['link'] = link;
    data['title'] = title;
    data['type'] = type;
    data['userId'] = userId;
    if (tags != null) {
      data['tags'] = [];
    }
    data['apkLink'] = apkLink;
    data['envelopePic'] = envelopePic;
    data['chapterId'] = chapterId;
    data['superChapterId'] = superChapterId;
    data['id'] = id;
    data['fresh'] = fresh;
    data['collect'] = collect;
    data['courseId'] = courseId;
    data['desc'] = desc;
    return data;
  }
}
