import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class RefreshCus extends StatelessWidget {
  final bool firstRefresh;
  final Widget child;
  final onRefresh;
  final onLoad;
  final EasyRefreshController outerController;
//  final GlobalKey<EasyRefreshState> easyRefreshKey;
//  final GlobalKey<RefreshHeaderState> _headerKey =
//  new GlobalKey<RefreshHeaderState>();
//  final GlobalKey<RefreshFooterState> _footerKey =
//  new GlobalKey<RefreshFooterState>();

  RefreshCus(
      {Key key,
      this.child,
      this.onRefresh,
      this.onLoad,
      this.outerController,
      this.firstRefresh,
//      this.easyRefreshKey
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
//      key: easyRefreshKey,
      firstRefresh: firstRefresh ?? false,
      onRefresh: onRefresh,
      onLoad: onLoad,
      controller: outerController,
//      outerController: outerController,
      child: child,
      header: MaterialHeader(),
      footer: MaterialFooter(),
    );
  }
}
