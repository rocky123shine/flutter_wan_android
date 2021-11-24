class ProjectEntity {
	List<ProjectData>? data;
	int? errorCode;
	String? errorMsg;

	ProjectEntity({this.data, this.errorCode, this.errorMsg});

	ProjectEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = <ProjectData>[];for (var v in (json['data'] as List)) { data!.add(ProjectData.fromJson(v)); }
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

class ProjectData {
	int? visible;
	List<void>? children;
	String? name;
	bool? userControlSetTop;
	int? id;
	int? courseId;
	int? parentChapterId;
	int? order;

	ProjectData({this.visible, this.children, this.name, this.userControlSetTop, this.id, this.courseId, this.parentChapterId, this.order});

	ProjectData.fromJson(Map<String, dynamic> json) {
		visible = json['visible'];
		if (json['children'] != null) {
			children = <Null>[];
		}
		name = json['name'];
		userControlSetTop = json['userControlSetTop'];
		id = json['id'];
		courseId = json['courseId'];
		parentChapterId = json['parentChapterId'];
		order = json['order'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['visible'] = visible;
		if (children != null) {
      data['children'] =  [];
    }
		data['name'] = name;
		data['userControlSetTop'] = userControlSetTop;
		data['id'] = id;
		data['courseId'] = courseId;
		data['parentChapterId'] = parentChapterId;
		data['order'] = order;
		return data;
	}
}
