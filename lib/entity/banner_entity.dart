class BannerEntity {
  List<BannerData>? data;
  int? errorCode;

  String? errorMsg;

  BannerEntity({this.data, this.errorCode, this.errorMsg});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <BannerData>[];
      for (var element in (json['data'] as List)) {
        data?.add(BannerData.fromJson(element));
      }
    }
  }


}

class BannerData {
  String imagePath = "";
  int? id;
  int? isVisible;
  String? title;
  int? type;
  String? url;
  String? desc;
  int? order;

  BannerData(
      {this.imagePath = "",
      this.id,
      this.isVisible,
      this.title,
      this.type,
      this.url,
      this.desc,
      this.order});

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
      imagePath: json['imagePath'],
      id: json['id'],
      isVisible: json['isVisible'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
      desc: json['desc'],
      order: json['order']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "isVisible": isVisible,
        "title": title,
        "type": type,
        "url": url,
        "desc": desc,
        "order": order
      };
}
