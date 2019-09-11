import 'package:zw_app/entity/product_img_entity.dart';

class ProductItemEntity {
	String c3Id;
  dynamic priceIn;
	String c3Name;
	int isEnable;
	String c1Id;
  dynamic priceOut;
	String remark;
  dynamic priceMarket;
	int number;
	String c2Name;
	int updateTime;
	String categoryId;
	int isHot;
	String id;
	int stock;
	String brand;
	String c2Id;
	List<ProductImgEntity> imgs;
	String c1Number;
	String c2Number;
	String c3Number;
	int createTime;
	int isNew;
	String c1Name;
  dynamic weight;
	int isDelete;
	String unit;
	String name;

	ProductItemEntity({this.c3Id, this.priceIn, this.c3Name, this.isEnable, this.c1Id, this.priceOut, this.remark, this.priceMarket, this.number, this.c2Name, this.updateTime, this.categoryId, this.isHot, this.id, this.stock, this.brand, this.c2Id, this.imgs, this.c1Number, this.c2Number, this.c3Number, this.createTime, this.isNew, this.c1Name, this.weight, this.isDelete, this.unit, this.name});

	ProductItemEntity.fromJson(Map<String, dynamic> json) {
		c3Id = json['c3_id'];
		priceIn = json['price_in'];
		c3Name = json['c3_name'];
		isEnable = json['is_enable'];
		c1Id = json['c1_id'];
		priceOut = json['price_out'];
		remark = json['remark'];
		priceMarket = json['price_market'];
		number = json['number'];
		c2Name = json['c2_name'];
		updateTime = json['update_time'];
		categoryId = json['category_id'];
		isHot = json['is_hot'];
		id = json['id'];
		stock = json['stock'];
		brand = json['brand'];
		c2Id = json['c2_id'];
		if (json['imgs'] != null) {
			imgs = new List<ProductImgEntity>();(json['imgs'] as List).forEach((v) { imgs.add(new ProductImgEntity.fromJson(v)); });
		}
		c1Number = json['c1_number'];
		c2Number = json['c2_number'];
		c3Number = json['c3_number'];
		createTime = json['create_time'];
		isNew = json['is_new'];
		c1Name = json['c1_name'];
		weight = json['weight'];
		isDelete = json['is_delete'];
		unit = json['unit'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['c3_id'] = this.c3Id;
		data['price_in'] = this.priceIn;
		data['c3_name'] = this.c3Name;
		data['is_enable'] = this.isEnable;
		data['c1_id'] = this.c1Id;
		data['price_out'] = this.priceOut;
		data['remark'] = this.remark;
		data['price_market'] = this.priceMarket;
		data['number'] = this.number;
		data['c2_name'] = this.c2Name;
		data['update_time'] = this.updateTime;
		data['category_id'] = this.categoryId;
		data['is_hot'] = this.isHot;
		data['id'] = this.id;
		data['stock'] = this.stock;
		data['brand'] = this.brand;
		data['c2_id'] = this.c2Id;
		if (this.imgs != null) {
      data['imgs'] =  this.imgs.map((v) => v.toJson()).toList();
    }
		data['c1_number'] = this.c1Number;
		data['c2_number'] = this.c2Number;
		data['c3_number'] = this.c3Number;
		data['create_time'] = this.createTime;
		data['is_new'] = this.isNew;
		data['c1_name'] = this.c1Name;
		data['weight'] = this.weight;
		data['is_delete'] = this.isDelete;
		data['unit'] = this.unit;
		data['name'] = this.name;
		return data;
	}
}

