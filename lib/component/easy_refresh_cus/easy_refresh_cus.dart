import 'package:flutter/material.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/material_footer.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/material_header.dart';

class EasyRefreshCus extends StatelessWidget {
  final bool firstRefresh;
  final Widget child;
  final OnRefresh onRefresh;
  final LoadMore loadMore;
  final ScrollController outerController;
  final GlobalKey<EasyRefreshState> easyRefreshKey;

  final GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();

  EasyRefreshCus(
      {Key key,
      this.child,
      this.onRefresh,
      this.loadMore,
      this.outerController,
      this.firstRefresh,
      this.easyRefreshKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: easyRefreshKey,
      firstRefresh: firstRefresh ?? false,
      onRefresh: onRefresh,
      loadMore: loadMore,
      outerController: outerController,
      child: child,
      refreshHeader: MaterialHeader(key: _headerKey),
      refreshFooter: MaterialFooter(key: _footerKey),
      noTopEndAnimation: true,
    );
  }
}
