import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/entity/category_item_entity.dart';
import 'package:zw_app/entity/category_list_entity.dart';
import 'package:zw_app/entity/group_info_entity.dart';
import 'package:zw_app/entity/group_queue_entity.dart';
import 'package:zw_app/entity/order_item_entity.dart';
import 'package:zw_app/entity/pay_card_entity.dart';
import 'package:zw_app/entity/product_img_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/entity/shop_cart_item_entity.dart';
import 'package:zw_app/entity/sub_category_with_product_entity.dart';
import 'package:zw_app/entity/test_entity.dart';
import 'package:zw_app/entity/user_coin_entity.dart';
import 'package:zw_app/entity/user_info_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "AddressItemEntity") {
      return AddressItemEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryItemEntity") {
      return CategoryItemEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryListEntity") {
      return CategoryListEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupInfoEntity") {
      return GroupInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupQueueEntity") {
      return GroupQueueEntity.fromJson(json) as T;
    } else if (T.toString() == "OrderItemEntity") {
      return OrderItemEntity.fromJson(json) as T;
    } else if (T.toString() == "PayCardEntity") {
      return PayCardEntity.fromJson(json) as T;
    } else if (T.toString() == "ProductImgEntity") {
      return ProductImgEntity.fromJson(json) as T;
    } else if (T.toString() == "ProductItemEntity") {
      return ProductItemEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopCartItemEntity") {
      return ShopCartItemEntity.fromJson(json) as T;
    } else if (T.toString() == "SubCategoryWithProductEntity") {
      return SubCategoryWithProductEntity.fromJson(json) as T;
    } else if (T.toString() == "TestEntity") {
      return TestEntity.fromJson(json) as T;
    } else if (T.toString() == "UserCoinEntity") {
      return UserCoinEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoEntity") {
      return UserInfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}