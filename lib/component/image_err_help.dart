import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageErrHelp extends StatelessWidget {
  final String imageUrl;

  const ImageErrHelp({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? 'http://',
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
