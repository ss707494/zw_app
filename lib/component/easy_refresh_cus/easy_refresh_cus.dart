import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class EasyRefreshCus extends StatelessWidget {
  final bool firstRefresh;
  final Widget child;
  final OnRefresh onRefresh;
  final LoadMore loadMore;
  final ScrollController outerController;

  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  EasyRefreshCus(
      {Key key,
      this.child,
      this.onRefresh,
      this.loadMore,
      this.outerController, this.firstRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: firstRefresh ?? false,
      onRefresh: onRefresh,
      loadMore: loadMore,
      outerController: outerController,
      child: child,
      refreshHeader: MaterialHeader(key: _headerKey),
      refreshFooter: MaterialFooter(key: _footerKey),
    );
  }
}
