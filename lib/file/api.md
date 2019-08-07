# zw_app

## 购物车 第一页面
App/shoppingCart/indexInfo
```json5
{
  "result": true,
  "msg": "查询成功",
  "data": {
    "subtotal": "@integer(10,100)",
    "productList|1-5": [ // 产品列表
      {
        "id": "@id",
        "imgUrl": "@pick(['https://images.pexels.com/photos/2614854/pexels-photo-2614854.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1936936/pexels-photo-1936936.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/916044/pexels-photo-916044.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 'https://images.pexels.com/photos/2223082/pexels-photo-2223082.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500','https://images.pexels.com/photos/2303781/pexels-photo-2303781.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?cs=srgb&dl=adorable-animal-baby-923360.jpg&fm=jpg', 'https://images.pexels.com/photos/923360/pexels-photo-923360.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/1296660/pexels-photo-1296660.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 'https://images.pexels.com/photos/33492/cat-red-cute-mackerel.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'])",
        "title": "@ctitle(3,5)",
        "weight": "@integer(1,100)",
        "unit": "g",
        "remark": "@ctitle(3,10)",
        "originalPrice": "@integer(1,100)",
        "sellPrice": "@integer(1,100)",
      }
    ],
  }
}
```

