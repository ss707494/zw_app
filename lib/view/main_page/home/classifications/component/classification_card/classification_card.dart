
import 'package:flutter/material.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/view/main_page/home/classifications/subClassifications/sub_classifications.dart';

class ClassificationCard extends StatelessWidget {
  final item;
  final int level;

  const ClassificationCard({Key key, this.item, this.level = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          mainNavigationKey.currentState.push(
            MaterialPageRoute(
              builder: (context) => SubClassifications(
                parentId: item['ID'],
              ),
            ),
          );
        },
        child: Container(
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[
              Image.network(
                item['Picture'] ?? '',
                height: 80,
                width: 100,
                fit: BoxFit.fill,
              ),
              Text('${item['F_CTNameC']}'),
            ],
          ),
        ),
      ),
    );
  }
}
