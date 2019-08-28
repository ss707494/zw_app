import 'package:flutter/material.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/entity/Category_item_entity.dart';
import 'package:zw_app/view/main_page/home/classifications/product_list/product_list.dart';
import 'package:zw_app/view/main_page/home/classifications/sub_classifications/sub_classifications.dart';

class ClassificationCard extends StatelessWidget {
  final CategoryItemEntity item;
  final int level;

  const ClassificationCard({Key key, this.item, this.level = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[600],
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 80,
                  child: ImageErrHelp(
                    imageUrl: item.imgUrl,
                  ),
                ),
                flex: 5,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${item.name}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
                flex: 2,
              ),
            ],
          ),
          Positioned.fill(
            child: InkWell(
              onTap: () {
                if (level == 3) {
                  mainNavigationKey.currentState.push(MaterialPageRoute(
                      builder: (context) => ProductList(
                            title: item.name,
                            typeId: item.id,
                          )));
                } else {
                  mainNavigationKey.currentState.push(MaterialPageRoute(
                      builder: (BuildContext context) => SubClassifications(
                            parentId: item.id,
                            level: level + 1,
                          )));
                }
              },
              splashColor: Colors.blue.withAlpha(80),
            ),
          )
        ],
      ),
    );
  }
}
