class UserInfoEntity {
	int createTime;
	String phone;
	String userName;
	String name;
	String id;
	String email;

	UserInfoEntity({this.createTime, this.phone, this.userName, this.name, this.id, this.email});

	UserInfoEntity.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		phone = json['phone'];
		userName = json['user_name'];
		name = json['name'];
		id = json['id'];
		email = json['email'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['phone'] = this.phone;
		data['user_name'] = this.userName;
		data['name'] = this.name;
		data['id'] = this.id;
		data['email'] = this.email;
		return data;
	}
}
