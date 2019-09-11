// language=GraphQL
String savePayCardDoc = r'''
mutation ($data: EditPayCardInput) {
  save_pay_card (editPayCardInput: $data) {
    flag
    msg
    payCard {
        id
    }
  }
}
''';

// language=GraphQL
String getPayCardList = r'''
query ($data: PayCardInput) {
    pay_card_list (payCardInput: $data) {
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
}
''';

// language=GraphQL
String setDefaultPayCard = r'''
mutation ($defaultId: String!) {
  set_default_pay_card (defaultId: $defaultId) {
    flag
  }
}
''';
