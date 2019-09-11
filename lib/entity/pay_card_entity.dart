class PayCardEntity {
	String code;
	String createTime;
	String city;
	String userName;
	dynamic isDefault;
	String zipCode;
	int isDelete;
	String addressDetail;
	String number;
	int updateTime;
	String userId;
	String contact;
	String name;
	String id;

	PayCardEntity({this.code, this.createTime, this.city, this.userName, this.isDefault, this.zipCode, this.isDelete, this.addressDetail, this.number, this.updateTime, this.userId, this.contact, this.name, this.id});

	PayCardEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		createTime = json['create_time'];
		city = json['city'];
		userName = json['user_name'];
		isDefault = json['is_default'];
		zipCode = json['zip_code'];
		isDelete = json['is_delete'];
		addressDetail = json['address_detail'];
		number = json['number'];
		updateTime = json['update_time'];
		userId = json['user_id'];
		contact = json['contact'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['create_time'] = this.createTime;
		data['city'] = this.city;
		data['user_name'] = this.userName;
		data['is_default'] = this.isDefault;
		data['zip_code'] = this.zipCode;
		data['is_delete'] = this.isDelete;
		data['address_detail'] = this.addressDetail;
		data['number'] = this.number;
		data['update_time'] = this.updateTime;
		data['user_id'] = this.userId;
		data['contact'] = this.contact;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
