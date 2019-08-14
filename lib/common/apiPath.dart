// 首页
final getHomeDataPath = '/App/WS_StyleSelect';
// 分类 商品
final getSubClassPath = '/App/WS_StyleSelectSub';
// 商品列表
final getProductListPath = '/App/WS_SortCommodity';
// 猜你喜欢列表
final getMayLikeListPath = '/App/WS_GuessLikeForYou';
// 限时选购
final getLimitedTimePath = '/App/WS_GuessLikeForYou';
// 主题甄选
final getSubjectSelectionPath = '/App/WS_GuessLikeForYou';
// 热销列表
final getHomeSalesListPath = '/App/WS_GuessLikeForYou';
// 热销列表 http://128.14.236.90:4433/mock/5d347e552b71b967c8c62b82/api/App/shoppingCart/indexInfo
final getCartIndexInfo = '/App/shoppingCart/indexInfo';
// 验证优惠码
final checkPromoCodePath = '/App/shoppingCart/checkPromoCode';
// 确认订单页面信息
final getConfirmOrderInfo = '/App/shoppingCart/getConfirmOrderInfo';
// 用户中心个人信息
final getUserCenterInfo = '/App/shoppingCart/getUserCenterInfo';
// 用户中心个人历史订单
final getUserOrderHistory = '/App/shoppingCart/getUserOrderHistory';

mock() => '''
"@integer(1, 10)"
"@pick(['1', '2', '3'])"
"@cword('0123456789', 11, 11)"
"@datetime"
"@ctitle(3,5)"
"@pick(['https://images.pexels.com/photos/2614854/pexels-photo-2614854.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1936936/pexels-photo-1936936.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/916044/pexels-photo-916044.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/2223082/pexels-photo-2223082.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500','https://images.pexels.com/photos/2303781/pexels-photo-2303781.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?cs=srgb&dl=adorable-animal-baby-923360.jpg&fm=jpg', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1296660/pexels-photo-1296660.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/33492/cat-red-cute-mackerel.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'])"
''';

// language=JSON5
mockDemo() => '''{
  "result": true,
  "msg": "查询成功",
  "data": {
    "orderList|1-10": [{ // 用户信息
      "id": "@id",
      "time": "@datetime",
      "state": "@pick([1, 2, 3])", // 订单状态
      "productNumber": "@integer(1, 10)", // 商品数量
      "amount": "@integer(1, 100)", // 金额
      "productList|1-5": [{
        "imgUrl": "@pick(['https://images.pexels.com/photos/2614854/pexels-photo-2614854.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1936936/pexels-photo-1936936.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/916044/pexels-photo-916044.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/2223082/pexels-photo-2223082.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500','https://images.pexels.com/photos/2303781/pexels-photo-2303781.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?cs=srgb&dl=adorable-animal-baby-923360.jpg&fm=jpg', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1296660/pexels-photo-1296660.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/33492/cat-red-cute-mackerel.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'])",
      }],
    }],
  }
}
''';
