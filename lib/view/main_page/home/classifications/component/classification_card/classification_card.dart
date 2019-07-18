import 'package:flutter/material.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/view/main_page/home/classifications/sub_classifications/sub_classifications.dart';

class ClassificationCard extends StatelessWidget {
  final item;
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
                child: Image.network(
                  item['Picture'] ?? '',
                  height: 80,
                  fit: BoxFit.fill,
                ),
                flex: 5,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('${item['F_CTNameC']}',
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
                if (level == 3) return;
                mainNavigationKey.currentState.push(MaterialPageRoute(builder: (BuildContext context) => SubClassifications(
                  parentId: item['ID'],
                  level: level + 1,
                )));
              },
              splashColor: Colors.blue.withAlpha(80),
            ),
          )
        ],
      ),
    );
  }
}
