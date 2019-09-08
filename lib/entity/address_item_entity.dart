class AddressItemEntity {
	String zip;
	String address;
	String createTime;
	String city;
	String contactInformation;
	int isDefault;
	int isDelete;
	int updateTime;
	String province;
	String userId;
	String district;
	String name;
	String id;

	AddressItemEntity({this.zip, this.address, this.createTime, this.city, this.contactInformation, this.isDefault, this.isDelete, this.updateTime, this.province, this.userId, this.district, this.name, this.id});

	AddressItemEntity.fromJson(Map<String, dynamic> json) {
		zip = json['zip'];
		address = json['address'];
		createTime = json['create_time'];
		city = json['city'];
		contactInformation = json['contact_information'];
		isDefault = json['is_default'];
		isDelete = json['is_delete'];
		updateTime = json['update_time'];
		province = json['province'];
		userId = json['user_id'];
		district = json['district'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['zip'] = this.zip;
		data['address'] = this.address;
		data['create_time'] = this.createTime;
		data['city'] = this.city;
		data['contact_information'] = this.contactInformation;
		data['is_default'] = this.isDefault;
		data['is_delete'] = this.isDelete;
		data['update_time'] = this.updateTime;
		data['province'] = this.province;
		data['user_id'] = this.userId;
		data['district'] = this.district;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
