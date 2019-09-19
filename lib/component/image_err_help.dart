import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zw_app/common/config.dart';

class ImageErrHelp extends StatelessWidget {
  final String imageUrl;

  const ImageErrHelp({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl.isEmpty || imageUrl.contains('localhost:')) ? Container() : CachedNetworkImage(
      imageUrl: imageUrl.contains('http') ? imageUrl : '$imgServerHost$imageUrl',
      fit: BoxFit.fill,
      placeholder: (context, url) => Column(
        children: <Widget>[
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
      errorWidget: (context, url, error) => Container(color: Colors.grey.withAlpha(80),),
    );
  }
}
