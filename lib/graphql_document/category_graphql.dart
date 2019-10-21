// language=GraphQL
String getCategoryListDoc = r'''
query ($data: CategoryInput) {
  category_list(CategoryInput: $data) {
    id
    name
    p2_id
    p2_name
    p3_id
    p3_name
    c2_id
    c2_name
    c3_id
    c3_name
    remark
    number
    parent_id
    update_time
    full_parent_id
    create_time
    sort
    img_url
    is_enable
  }
}
''';

// language=GraphQL
String getSubClassDoc = r'''
query ($data: CategoryInput, $proData: ProductInput) {
  category_list(CategoryInput: $data) {
    id
    name
    p2_id
    p2_name
    p3_id
    p3_name
    c2_id
    c2_name
    c3_id
    c3_name
    remark
    number
    parent_id
    update_time
    full_parent_id
    create_time
    sort
    img_url
    is_enable
  }
  product_list (ListInput: $proData) {
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
    is_group
    group_amount
    group_precision
    group_remark
    imgs {
      id
      name
      number
      product_id
      url
    }
    group_info {
      doing
      finish
    }
  }
}
''';
