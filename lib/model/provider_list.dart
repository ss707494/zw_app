import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/address.dart';
import 'package:zw_app/model/classifications.dart';
import 'package:zw_app/model/home_sales.dart';
import 'package:zw_app/model/http.dart';
import 'package:zw_app/model/limited_time.dart';
import 'package:zw_app/model/log.dart';
import 'package:zw_app/model/login.dart';
import 'package:zw_app/model/may_like.dart';
import 'package:zw_app/model/pay_card.dart';
import 'package:zw_app/model/product.dart';
import 'package:zw_app/model/router.dart';
import 'package:zw_app/model/shopping_cart.dart';
import 'package:zw_app/model/sub_class.dart';
import 'package:zw_app/model/subject_selection.dart';
import 'package:zw_app/model/user_center.dart';
import 'confirm_order.dart';
import 'order_history.dart';

class ProviderHelp extends StatelessWidget {
  final Widget child;

  const ProviderHelp({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => LoginModel()),
        ChangeNotifierProvider(builder: (_) => LogInfoModel()),
        ChangeNotifierProvider(builder: (_) => RouterModel()),
        ChangeNotifierProvider(builder: (_) => ClassificationsModel()),
        ChangeNotifierProvider(builder: (_) => HttpModel()),
        ChangeNotifierProvider(builder: (_) => SubClassModel()),
        ChangeNotifierProvider(builder: (_) => ProductModel()),
        ChangeNotifierProvider(builder: (_) => MayLikeModel()),
        ChangeNotifierProvider(builder: (_) => LimitedTimeModel()),
        ChangeNotifierProvider(builder: (_) => SubjectSelectionModel()),
        ChangeNotifierProvider(builder: (_) => HomeSalesModel()),
        ChangeNotifierProvider(builder: (_) => ShoppingCartModel()),
        ChangeNotifierProvider(builder: (_) => ConfirmOrderModel()),
        ChangeNotifierProvider(builder: (_) => UserCenterModel()),
        ChangeNotifierProvider(builder: (_) => OrderHistoryModel()),
        ChangeNotifierProvider(builder: (_) => AddressModel()),
        ChangeNotifierProvider(builder: (_) => PayCardModel()),
      ],
      child: child,
    );
  }
}
