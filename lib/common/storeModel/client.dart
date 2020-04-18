import 'package:artemis/artemis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:gql/language.dart" as lang;
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as JA;
import 'package:zw_app/common/graphql_client_type.dart';
import 'package:zw_app/common/secure_storage.dart';
import 'package:zw_app/type__graphql/art_graphql/art_graphql_query.dart';

class QueryResultForArt<T> {
  QueryResultForArt({
    this.data,
    this.errors,
    bool loading,
    bool optimistic,
    QueryResultSource source,
  })  : timestamp = DateTime.now(),
        this.source = source ??
            ((loading == true)
                ? QueryResultSource.Loading
                : (optimistic == true)
                    ? QueryResultSource.OptimisticResult
                    : null);

  QueryResultForArt.factory(QueryResult result, GraphQLQuery query)
      : errors = result.errors,
        source = result.source,
        timestamp = result.timestamp,
        data = query.parse(result.data);

  T data;
  DateTime timestamp;
  QueryResultSource source;
  List<GraphQLError> errors;

  bool get loading => source == QueryResultSource.Loading;

  bool get optimistic => source == QueryResultSource.OptimisticResult;

  bool get hasErrors {
    if (errors == null) {
      return false;
    }
    return errors.isNotEmpty;
  }

  void addError(GraphQLError graphQLError) {
    if (errors != null) {
      errors.add(graphQLError);
    } else {
      errors = <GraphQLError>[graphQLError];
    }
  }
}

Future<QueryResult> _artQueryGraphql<T, U extends JA.JsonSerializable>(
    GraphQLQuery<T, U> query,
    {fetchPolicy}) async {
  QueryResult res = await graphQLClient
      .query(QueryOptions(
          document: lang.printNode(query.document),
          variables: query.getVariablesMap(),
          fetchPolicy: fetchPolicy))
      .catchError((err) {
    print('sslog::: graphql err:: $err');
    Fluttertoast.showToast(msg: err.toString());
  }).whenComplete(() {});
//  sslog: path: $document
  String logInfo = '''
sslog: data: $query
sslog: res: ${res.data}
''';
  print(logInfo);
  return res;
}

Future<QueryResultForArt<T>>
    artGraphqlQueryByType__Graphql<T, U extends JA.JsonSerializable>(
        GraphQLQuery<T, U> query,
        {fetchPolicy = FetchPolicy.cacheAndNetwork,
        option}) async {
//  print('token:::::::::: ${await getStorageByKey('token')}');
  QueryResult res = await _artQueryGraphql(query, fetchPolicy: fetchPolicy);

  if (res.hasErrors) {
    for (var error in res.errors) {
      if (error.extensions['code'] == 'UNAUTHENTICATED') {
        if (error.message == 'first') {
          print('sslog:::: get refreshtoken type---------');
          var refreshtoken = await getStorageByKey('refreshtoken');
          if (refreshtoken != null) {
            final res = await _artQueryGraphql(RefreshTokenQuery(
                variables: RefreshTokenArguments(refreshToken: refreshtoken)));
            var refreshData = res.data['refreshToken'];
            if (refreshData != null) {
              await setStorage(key: 'token', value: refreshData['token']);
              await setStorage(
                  key: 'refreshtoken', value: refreshData['refreshtoken']);
              QueryResult resRetry =
                  await _artQueryGraphql(query, fetchPolicy: fetchPolicy);
              return QueryResultForArt.factory(resRetry, query);
            }
          }
        }
      }
    }
    print('sslog::: graphql err:: ${res.errors}');
    String errMsg = res.errors.map((e) => e.message).join('');
    Fluttertoast.showToast(msg: errMsg);
    return QueryResultForArt.factory(res, query);
  }
  return QueryResultForArt.factory(res, query);
}
