class HotSearchEntity {
  List<HotSearchData>? data;
  int? errorCode;
  String? errorMsg;

  HotSearchEntity({this.data, this.errorCode, this.errorMsg});

  HotSearchEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HotSearchData>[];
      json['data'].forEach((v) {
        data!.add(HotSearchData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
  }
}

class HotSearchData {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotSearchData({this.id, this.link, this.name, this.order, this.visible});

  HotSearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['name'] = name;
    data['order'] = order;
    data['visible'] = visible;
    return data;
  }
}
