// language=GraphQL
String getUserCenterDataDoc = r'''
query {
  user_info {
    id
    name
    type
    create_time
    update_time
    user_name
    phone
    email
  }
  user_coin {
    card_number
    current_mouth_icons
    next_mouth_icons
  }
  order_list {
    id
  }
}
''';
