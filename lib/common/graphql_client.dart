library graphql_client;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/config.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/common/secure_storage.dart';
import 'package:zw_app/model/http.dart';

import 'http.dart';

final GraphQLClient graphQLClient = GraphQLClient(
    cache: InMemoryCache(),
    link: AuthLink(getToken: () async {
      return (await getStorageByKey('token') ?? '');
    })
        .concat(HttpLink(uri: '${serverHost}api')));

Future<QueryResult> graphqlQuery(context, document, {data = const <String, dynamic>{}, fetchPolicy = FetchPolicy.cacheAndNetwork}) async {
//  print('token:::::::::: ${await getStorageByKey('token')}');
  print('sslog::: graphqlQuery::$data');
  QueryResult res = await _queryGraphql(context, document, data: data, fetchPolicy: fetchPolicy);
  if (res.hasErrors) {
    String errMsg = res.errors.map((e) => e.message).join('');
    if (errMsg.contains('401')) {
      // refresh token
      if (errMsg.contains('first')) {
        print('sslog:::: get refreshtoken');
        var refreshtoken = await getStorageByKey('refreshtoken');
        if (refreshtoken != null) {
          var refreshData = await httpPost(context, 'api/getTokenRefresh',
              data: {'refreshtoken': refreshtoken});
          if (refreshData != null && refreshData?.data['data'] == 1) {
            HttpModel httpModel = Provider.of<HttpModel>(context);
            httpModel.setTokenAsync(refreshData.data['token']);
            httpModel.setRefreshTokenAsync(refreshData.data['refreshtoken']);

            QueryResult resRetry = await _queryGraphql(context, document, data: data);

            return resRetry;
          }
        }
      }
      // goto login
      Fluttertoast.showToast(msg: '请重新登录');
      mainNavigationKey.currentState.pushNamedAndRemoveUntil('login', (r) => false);
      return null;
    } else {
      print('sslog::: graphql err:: ${res.errors}');
      Fluttertoast.showToast(msg: errMsg);
      return res;
    }
  }

  return res;
}

Future<QueryResult> _queryGraphql (context, document, {data, fetchPolicy}) async {
  final httpLoadingModel = Provider.of<HttpModel>(context, listen: false);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(document, true);
  });
  QueryResult res = await graphQLClient
      .query(QueryOptions(document: document, variables: data as Map<String, dynamic>, fetchPolicy: fetchPolicy))
      .catchError((err) {
    print('sslog::: graphql err:: $err');
    Fluttertoast.showToast(msg: err.toString());
  }).whenComplete(() {
    httpLoadingModel.setCurrent(document, false);
  });
//  sslog: path: $document
  String logInfo = '''
sslog: data: $data
sslog: res: ${res.data}
''';
  print(logInfo);
  return res;
}
