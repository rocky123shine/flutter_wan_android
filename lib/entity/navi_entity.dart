class NaviEntity {
	List<NaviData>? data;
	int? errorCode;
	String? errorMsg;

	NaviEntity({this.data, this.errorCode, this.errorMsg});

	NaviEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = <NaviData>[];for (var v in (json['data'] as List)) { data!.add(NaviData.fromJson(v)); }
		}
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (this.data != null) {
      data['data'] =  this.data!.map((v) => v.toJson()).toList();
    }
		data['errorCode'] = errorCode;
		data['errorMsg'] = errorMsg;
		return data;
	}
}

class NaviData {
	String? name;
	List<NaviDataArticle>? articles;
	int? cid;

	NaviData({this.name, this.articles, this.cid});

	NaviData.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		if (json['articles'] != null) {
			articles = <NaviDataArticle>[];for (var v in (json['articles'] as List)) { articles!.add(NaviDataArticle.fromJson(v)); }
		}
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		if (articles != null) {
      data['articles'] =  articles!.map((v) => v.toJson()).toList();
    }
		data['cid'] = cid;
		return data;
	}
}

class NaviDataArticle {
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
	List<Null>? tags;
	String? apkLink;
	String? envelopePic;
	int? chapterId;
	int? superChapterId;
	int? id;
	bool? fresh;
	bool? collect;
	int? courseId;
	String? desc;

	NaviDataArticle({this.superChapterName, this.publishTime, this.visible, this.niceDate, this.projectLink, this.author, this.prefix, this.zan, this.origin, this.chapterName, this.link, this.title, this.type, this.userId, this.tags, this.apkLink, this.envelopePic, this.chapterId, this.superChapterId, this.id, this.fresh, this.collect, this.courseId, this.desc});

	NaviDataArticle.fromJson(Map<String, dynamic> json) {
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
		data['publishTime'] = this.publishTime;
		data['visible'] = this.visible;
		data['niceDate'] = this.niceDate;
		data['projectLink'] = this.projectLink;
		data['author'] = this.author;
		data['prefix'] = this.prefix;
		data['zan'] = this.zan;
		data['origin'] = this.origin;
		data['chapterName'] = this.chapterName;
		data['link'] = this.link;
		data['title'] = this.title;
		data['type'] = this.type;
		data['userId'] = this.userId;
		if (this.tags != null) {
      data['tags'] =  [];
    }
		data['apkLink'] = this.apkLink;
		data['envelopePic'] = this.envelopePic;
		data['chapterId'] = this.chapterId;
		data['superChapterId'] = this.superChapterId;
		data['id'] = this.id;
		data['fresh'] = this.fresh;
		data['collect'] = this.collect;
		data['courseId'] = this.courseId;
		data['desc'] = this.desc;
		return data;
	}
}
