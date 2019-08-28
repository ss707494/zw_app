import 'package:zw_app/entity/Category_item_entity.dart';

class CategoryListEntity {
	List<CategoryItemEntity> categoryList;

	CategoryListEntity({this.categoryList});

	CategoryListEntity.fromJson(Map<String, dynamic> json) {
		if (json['category_list'] != null) {
			categoryList = new List<CategoryItemEntity>();(json['category_list'] as List).forEach((v) { categoryList.add(new CategoryItemEntity.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.categoryList != null) {
      data['category_list'] =  this.categoryList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}
