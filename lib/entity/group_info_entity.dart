class GroupInfoEntity {
	int doing;
	int finish;

	GroupInfoEntity({this.doing, this.finish});

	GroupInfoEntity.fromJson(Map<String, dynamic> json) {
		doing = json['doing'];
		finish = json['finish'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['doing'] = this.doing;
		data['finish'] = this.finish;
		return data;
	}
}
