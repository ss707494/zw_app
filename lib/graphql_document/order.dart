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
