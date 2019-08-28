import 'package:zw_app/entity/Category_item_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';

class SubCategoryWithProductEntity {
	List<CategoryItemEntity> categoryList;
	List<ProductItemEntity> productList;

	SubCategoryWithProductEntity({this.categoryList, this.productList});

	SubCategoryWithProductEntity.fromJson(Map<String, dynamic> json) {
		if (json['category_list'] != null) {
			categoryList = new List<CategoryItemEntity>();(json['category_list'] as List).forEach((v) { categoryList.add(new CategoryItemEntity.fromJson(v)); });
		}
		if (json['product_list'] != null) {
			productList = new List<ProductItemEntity>();(json['product_list'] as List).forEach((v) { productList.add(new ProductItemEntity.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.categoryList != null) {
      data['category_list'] =  this.categoryList.map((v) => v.toJson()).toList();
    }
		if (this.productList != null) {
      data['product_list'] =  this.productList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

