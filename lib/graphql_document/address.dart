// language=GraphQL
String saveAddressDoc = r'''
mutation ($data: EditAddressInput) {
  save_address (editAddressInput: $data) {
    flag
    msg
    address {
        id
    }
  }
}
''';

// language=GraphQL
String getAddressList = r'''
query ($data: AddressInput) {
    address_list (addressInput: $data) {
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
    }
}
''';

// language=GraphQL
String setDefaultAddress = r'''
mutation ($defaultId: String!) {
  set_default_address(defaultId: $defaultId) {
    flag
  }
}
''';

