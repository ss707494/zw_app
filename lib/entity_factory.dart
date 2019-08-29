import 'package:zw_app/entity/category_item_entity.dart';
import 'package:zw_app/entity/category_list_entity.dart';
import 'package:zw_app/entity/product_img_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/entity/shop_cart_item_entity.dart';
import 'package:zw_app/entity/sub_category_with_product_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CategoryItemEntity") {
      return CategoryItemEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryListEntity") {
      return CategoryListEntity.fromJson(json) as T;
    } else if (T.toString() == "ProductImgEntity") {
      return ProductImgEntity.fromJson(json) as T;
    } else if (T.toString() == "ProductItemEntity") {
      return ProductItemEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopCartItemEntity") {
      return ShopCartItemEntity.fromJson(json) as T;
    } else if (T.toString() == "SubCategoryWithProductEntity") {
      return SubCategoryWithProductEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}