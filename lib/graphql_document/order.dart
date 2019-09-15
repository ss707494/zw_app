// language=GraphQL
String saveOrderDoc = r'''
mutation($data: SaveOrderInput) {
  save_order(saveOrderInput: $data) {
    flag
    order {
      id
      number
    }
  }
}
''';

// language=GraphQL
String getOrderDetailDoc = r'''query ($id: String!) {
    order_detail(id: $id) {
        id
        name
        create_time
        update_time
        is_delete
        number
        state
        actually_paid
        address_id
        address {
            id
            name
            create_time
            update_time
            is_delete
            zip
            province
            city
            district
            address
            is_default
            user_id
            contact_information
            contact_user_name
        }
        payment_method_card_id
        payment_method {
            id
            name
            create_time
            update_time
            is_delete

            is_default
            user_id
            number
            code
            user_name
            address_detail
            zip_code
            city
            contact
        }
        subtotal
        coupon_discount
        vip_discount
        transportation_costs
        sale_tax
        product {
            id
            name
            create_time
            update_time
            category_id
            is_enable
            is_hot
            is_new
            is_delete
            remark
            stock
            unit
            weight
            price_in
            price_out
            price_market
            brand
            number
            c3_id
            c3_name
            c3_number
            c2_id
            c2_name
            c2_number
            c1_id
            c1_name
            c1_number
            sort
            oneImgUrl
            imgs {
                id
                name
                number
                product_id
                url
            }
        }
    }
}
''';

// language=GraphQL
String getOrderListDoc = r'''query {
    order_list {
        id
        name
        create_time
        update_time
        is_delete
        number
        state
        actually_paid
        address_id
        address {
            id
            name
            create_time
            update_time
            is_delete
            zip
            province
            city
            district
            address
            is_default
            user_id
            contact_information
            contact_user_name
        }
        payment_method_card_id
        payment_method {
            id
            name
            create_time
            update_time
            is_delete

            is_default
            user_id
            number
            code
            user_name
            address_detail
            zip_code
            city
            contact
        }
        subtotal
        coupon_discount
        vip_discount
        transportation_costs
        sale_tax
        product {
            id
            name
            create_time
            update_time
            category_id
            is_enable
            is_hot
            is_new
            is_delete
            remark
            stock
            unit
            weight
            price_in
            price_out
            price_market
            brand
            number
            c3_id
            c3_name
            c3_number
            c2_id
            c2_name
            c2_number
            c1_id
            c1_name
            c1_number
            sort
            oneImgUrl
            imgs {
                id
                name
                number
                product_id
                url
            }
        }
    }
}
''';
