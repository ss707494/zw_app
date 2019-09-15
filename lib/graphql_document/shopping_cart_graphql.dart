// language=GraphQL
String addToShopCartDoc = r'''
mutation ($data: ShopCartInput) {
  addToShopCart(ShopCartInput: $data) {
    flag
    msg
  }
}
''';

// language=GraphQL
String shopCartListDoc = r'''
query ($data: ShopCartInput) {
  shop_cart_list(ShopCartInput: $data) {
    id
    name
    create_time
    update_time
    product_id
    is_next
    number
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
String saveShopCartDoc = r'''
mutation ($data: SaveShopCartInput) {
  save_shop_cart(SaveShopCartInput: $data) {
    flag
    msg
  }
}
''';

// language=GraphQL
String removeShopCartDoc = r'''
mutation ($id: String!) {
  remove_shop_cart(id: $id) {
    flag
    msg
  }
}
''';

// language=GraphQL
String removeAllShopCartDoc = r'''
mutation ($ids: [String!]!) {
  remove_all_shop_cart(ids: $ids) {
    flag
    msg
  }
}
''';

