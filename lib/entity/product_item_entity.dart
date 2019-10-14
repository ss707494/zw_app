import 'package:zw_app/entity/product_img_entity.dart';

class ProductItemEntity {
  dynamic c3Id;
  int priceIn;
  dynamic c3Name;
  int isEnable;
  dynamic c1Id;
  int priceOut;
  String remark;
  int priceMarket;
  int number;
  int updateTime;
  dynamic c2Name;
  String categoryId;
  int isHot;
  String id;
  int stock;
  String brand;
  dynamic c2Id;
  List<ProductImgEntity> imgs;
  dynamic c3Number;
  dynamic c2Number;
  dynamic c1Number;
  int createTime;
  int isNew;
  dynamic c1Name;
  int weight;
  int sort;
  int isDelete;
  String unit;
  String oneImgUrl;
  String name;
  int isGroup;
  int groupPrecision;
  int groupAmount;

  ProductItemEntity({this.c3Id, this.priceIn, this.c3Name, this.isEnable, this.c1Id, this.priceOut, this.remark, this.priceMarket, this.number, this.updateTime, this.c2Name, this.categoryId, this.isHot, this.id, this.stock, this.brand, this.c2Id, this.imgs, this.c3Number, this.c2Number, this.c1Number, this.createTime, this.isNew, this.c1Name, this.weight, this.sort, this.isDelete, this.unit, this.oneImgUrl, this.name, this.isGroup, this.groupPrecision, this.groupAmount});

  ProductItemEntity.fromJson(Map<String, dynamic> json) {
    groupAmount = json['group_amount'];
    groupPrecision = json['group_precision'];
    c3Id = json['c3_id'];
    priceIn = json['price_in'];
    c3Name = json['c3_name'];
    isEnable = json['is_enable'];
    c1Id = json['c1_id'];
    priceOut = json['price_out'];
    remark = json['remark'];
    priceMarket = json['price_market'];
    number = json['number'];
    updateTime = json['update_time'];
    c2Name = json['c2_name'];
    categoryId = json['category_id'];
    isHot = json['is_hot'];
    id = json['id'];
    stock = json['stock'];
    brand = json['brand'];
    c2Id = json['c2_id'];
    if (json['imgs'] != null) {
      imgs = new List<ProductImgEntity>();(json['imgs'] as List).forEach((v) { imgs.add(new ProductImgEntity.fromJson(v)); });
    }
    c3Number = json['c3_number'];
    c2Number = json['c2_number'];
    c1Number = json['c1_number'];
    createTime = json['create_time'];
    isNew = json['is_new'];
    c1Name = json['c1_name'];
    weight = json['weight'];
    sort = json['sort'];
    isDelete = json['is_delete'];
    unit = json['unit'];
    oneImgUrl = json['oneImgUrl'];
    name = json['name'];
    isGroup = json['is_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_amount'] = this.groupAmount;
    data['group_precision'] = this.groupPrecision;
    data['c3_id'] = this.c3Id;
    data['price_in'] = this.priceIn;
    data['c3_name'] = this.c3Name;
    data['is_enable'] = this.isEnable;
    data['c1_id'] = this.c1Id;
    data['price_out'] = this.priceOut;
    data['remark'] = this.remark;
    data['price_market'] = this.priceMarket;
    data['number'] = this.number;
    data['update_time'] = this.updateTime;
    data['c2_name'] = this.c2Name;
    data['category_id'] = this.categoryId;
    data['is_hot'] = this.isHot;
    data['id'] = this.id;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['c2_id'] = this.c2Id;
    if (this.imgs != null) {
      data['imgs'] =  this.imgs.map((v) => v.toJson()).toList();
    }
    data['c3_number'] = this.c3Number;
    data['c2_number'] = this.c2Number;
    data['c1_number'] = this.c1Number;
    data['create_time'] = this.createTime;
    data['is_new'] = this.isNew;
    data['c1_name'] = this.c1Name;
    data['weight'] = this.weight;
    data['sort'] = this.sort;
    data['is_delete'] = this.isDelete;
    data['unit'] = this.unit;
    data['oneImgUrl'] = this.oneImgUrl;
    data['name'] = this.name;
    data['is_group'] = this.isGroup;
    return data;
  }
}
