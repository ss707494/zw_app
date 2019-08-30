import 'package:zw_app/entity/product_item_entity.dart';

class ShopCartItemEntity {
	int isNext;
	int number;
	int updateTime;
	ProductItemEntity product;
	int createTime;
	String productId;
	dynamic name;
	String id;

	ShopCartItemEntity({this.isNext, this.number, this.updateTime, this.product, this.createTime, this.productId, this.name, this.id});

	ShopCartItemEntity.fromJson(Map<String, dynamic> json) {
		isNext = json['is_next'];
		number = json['number'];
		updateTime = json['update_time'];
		product = json['product'] != null ? new ProductItemEntity.fromJson(json['product']) : null;
		createTime = json['create_time'];
		productId = json['product_id'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_next'] = this.isNext;
		data['number'] = this.number;
		data['update_time'] = this.updateTime;
		if (this.product != null) {
      data['product'] = this.product.toJson();
    }
		data['create_time'] = this.createTime;
		data['product_id'] = this.productId;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
