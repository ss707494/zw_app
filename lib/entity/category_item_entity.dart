class CategoryItemEntity {
	String c2Id;
	String c3Id;
	String c3Name;
	int createTime;
	int isEnable;
	dynamic p3Name;
	dynamic remark;
	dynamic sort;
	int number;
	dynamic p2Name;
	String c2Name;
	dynamic updateTime;
	dynamic p3Id;
	dynamic fullParentId;
	String imgUrl;
	String parentId;
	String name;
	dynamic p2Id;
	String id;

	CategoryItemEntity({this.c2Id, this.c3Id, this.c3Name, this.createTime, this.isEnable, this.p3Name, this.remark, this.sort, this.number, this.p2Name, this.c2Name, this.updateTime, this.p3Id, this.fullParentId, this.imgUrl, this.parentId, this.name, this.p2Id, this.id});

	CategoryItemEntity.fromJson(Map<String, dynamic> json) {
		c2Id = json['c2_id'];
		c3Id = json['c3_id'];
		c3Name = json['c3_name'];
		createTime = json['create_time'];
		isEnable = json['is_enable'];
		p3Name = json['p3_name'];
		remark = json['remark'];
		sort = json['sort'];
		number = json['number'];
		p2Name = json['p2_name'];
		c2Name = json['c2_name'];
		updateTime = json['update_time'];
		p3Id = json['p3_id'];
		fullParentId = json['full_parent_id'];
		imgUrl = json['img_url'];
		parentId = json['parent_id'];
		name = json['name'];
		p2Id = json['p2_id'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['c2_id'] = this.c2Id;
		data['c3_id'] = this.c3Id;
		data['c3_name'] = this.c3Name;
		data['create_time'] = this.createTime;
		data['is_enable'] = this.isEnable;
		data['p3_name'] = this.p3Name;
		data['remark'] = this.remark;
		data['sort'] = this.sort;
		data['number'] = this.number;
		data['p2_name'] = this.p2Name;
		data['c2_name'] = this.c2Name;
		data['update_time'] = this.updateTime;
		data['p3_id'] = this.p3Id;
		data['full_parent_id'] = this.fullParentId;
		data['img_url'] = this.imgUrl;
		data['parent_id'] = this.parentId;
		data['name'] = this.name;
		data['p2_id'] = this.p2Id;
		data['id'] = this.id;
		return data;
	}
}
