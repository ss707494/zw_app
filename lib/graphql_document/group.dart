// language=GraphQL
String getGroupDetail = r'''
query($data: GroupQueueListInput) {
  group_queue_list(groupQueueListInput: $data) {
    create_time
    fill_amount
    id
    is_delete
    name
    product_id
    update_time
    product {
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
    }
  }
}
''';
