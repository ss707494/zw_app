import 'package:zw_app/entity/product_item_entity.dart';

class GroupQueueEntity {
	int fillAmount;
	dynamic updateTime;
	ProductItemEntity product;
	String createTime;
	String productId;
	dynamic name;
	String id;
	int isDelete;
	int selectAmount = 0;

	GroupQueueEntity({this.fillAmount, this.updateTime, this.product, this.createTime, this.productId, this.name, this.id, this.isDelete, this.selectAmount});

	GroupQueueEntity.fromJson(Map<String, dynamic> json) {
		fillAmount = json['fill_amount'];
		updateTime = json['update_time'];
		product = json['product'] != null ? new ProductItemEntity.fromJson(json['product']) : null;
		createTime = json['create_time'];
		productId = json['product_id'];
		name = json['name'];
		id = json['id'];
		isDelete = json['is_delete'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['fill_amount'] = this.fillAmount;
		data['update_time'] = this.updateTime;
		if (this.product != null) {
      data['product'] = this.product.toJson();
    }
		data['create_time'] = this.createTime;
		data['product_id'] = this.productId;
		data['name'] = this.name;
		data['id'] = this.id;
		data['is_delete'] = this.isDelete;
		return data;
	}
}

