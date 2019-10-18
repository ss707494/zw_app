import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/entity/pay_card_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';

class OrderItemEntity {
	List<ProductItemEntity> product;
	AddressItemEntity address;
	int createTime;
	String paymentMethodCardId;
	int transportationCosts;
	String addressId;
	int isDelete;
	String number;
	dynamic actuallyPaid;
	int updateTime;
	dynamic subtotal;
  dynamic discountProductTotal;
	dynamic name;
	int saleTax;
	String id;
	int state;
	dynamic vipDiscount;
	PayCardEntity paymentMethod;
	dynamic couponDiscount;

	OrderItemEntity({this.product, this.address, this.createTime, this.paymentMethodCardId, this.transportationCosts, this.addressId, this.isDelete, this.number, this.actuallyPaid, this.updateTime, this.subtotal, this.name, this.saleTax, this.id, this.state, this.vipDiscount, this.paymentMethod, this.couponDiscount, this.discountProductTotal});

	OrderItemEntity.fromJson(Map<String, dynamic> json) {
		if (json['product'] != null) {
			product = new List<ProductItemEntity>();(json['product'] as List).forEach((v) { product.add(new ProductItemEntity.fromJson(v)); });
		}
		address = json['address'] != null ? new AddressItemEntity.fromJson(json['address']) : null;
		createTime = json['create_time'];
		paymentMethodCardId = json['payment_method_card_id'];
		transportationCosts = json['transportation_costs'];
		addressId = json['address_id'];
		isDelete = json['is_delete'];
		number = json['number'];
		actuallyPaid = json['actually_paid'];
		updateTime = json['update_time'];
		subtotal = json['subtotal'];
    discountProductTotal = json['discount_product_total'];
		name = json['name'];
		saleTax = json['sale_tax'];
		id = json['id'];
		state = json['state'];
		vipDiscount = json['vip_discount'];
		paymentMethod = json['payment_method'] != null ? new PayCardEntity.fromJson(json['payment_method']) : null;
		couponDiscount = json['coupon_discount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.product != null) {
      data['product'] =  this.product.map((v) => v.toJson()).toList();
    }
		if (this.address != null) {
      data['address'] = this.address.toJson();
    }
		data['create_time'] = this.createTime;
		data['payment_method_card_id'] = this.paymentMethodCardId;
		data['transportation_costs'] = this.transportationCosts;
		data['address_id'] = this.addressId;
		data['is_delete'] = this.isDelete;
		data['number'] = this.number;
		data['actually_paid'] = this.actuallyPaid;
		data['update_time'] = this.updateTime;
		data['subtotal'] = this.subtotal;
    data['discount_product_total'] = this.discountProductTotal;
		data['name'] = this.name;
		data['sale_tax'] = this.saleTax;
		data['id'] = this.id;
		data['state'] = this.state;
		data['vip_discount'] = this.vipDiscount;
		if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod.toJson();
    }
		data['coupon_discount'] = this.couponDiscount;
		return data;
	}
}

