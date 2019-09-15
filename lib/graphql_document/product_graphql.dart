// language=GraphQL
String getProductListDoc = r'''query ($data: ProductInput) {
    product_list(ListInput: $data) {
        brand
        c1_id
        c1_name
        c1_number
        c2_id
        c2_name
        c2_number
        c3_id
        c3_name
        c3_number
        category_id
        create_time
        id
        is_delete
        is_enable
        is_hot
        is_new
        name
        number
        price_in
        price_market
        price_out
        remark
        stock
        unit
        update_time
        weight
        imgs {
            id
            name
            number
            product_id
            url
        }
    }
}
''';

String productDoc = r'''
    brand
    c1_id
    c1_name
    c1_number
    c2_id
    c2_name
    c2_number
    c3_id
    c3_name
    c3_number
    category_id
    create_time
    id
    is_delete
    is_enable
    is_hot
    is_new
    name
    number
    price_in
    price_market
    price_out
    remark
    stock
    unit
    update_time
    weight
    imgs {
      id
      name
      number
      product_id
      url
    }
''';

// language=GraphQL
String getProductListWithFeatureDoc = r'''
query ($data: ProductInput) {
  product_list(ListInput: $data) {
    brand
    c1_id
    c1_name
    c1_number
    c2_id
    c2_name
    c2_number
    c3_id
    c3_name
    c3_number
    category_id
    create_time
    id
    is_delete
    is_enable
    is_hot
    is_new
    name
    number
    price_in
    price_market
    price_out
    remark
    stock
    unit
    update_time
    weight
    imgs {
      id
      name
      number
      product_id
      url
    }
  }
}
''';

