class ProductImgEntity {
	int number;
	String productId;
	String name;
	String id;
	String url;

	ProductImgEntity({this.number, this.productId, this.name, this.id, this.url});

	ProductImgEntity.fromJson(Map<String, dynamic> json) {
		number = json['number'];
		productId = json['product_id'];
		name = json['name'];
		id = json['id'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['number'] = this.number;
		data['product_id'] = this.productId;
		data['name'] = this.name;
		data['id'] = this.id;
		data['url'] = this.url;
		return data;
	}
}
