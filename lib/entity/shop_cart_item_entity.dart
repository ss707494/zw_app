import 'package:zw_app/entity/product_item_entity.dart';

class ShopCartItemEntity {
	ProductItemEntity product;
	String productId;
	String id;

	ShopCartItemEntity({this.product, this.productId, this.id});

	ShopCartItemEntity.fromJson(Map<String, dynamic> json) {
		product = json['product'] != null ? new ProductItemEntity.fromJson(json['product']) : null;
		productId = json['product_id'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.product != null) {
      data['product'] = this.product.toJson();
    }
		data['product_id'] = this.productId;
		data['id'] = this.id;
		return data;
	}
}
