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
    id
    name
    number
    weight
    unit
    price_market
    price_in
    price_out
    imgs {
      id
      name
      url
      number
    }
  }
}
''';
