import 'package:artemis/artemis.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart' as JA;
import 'client.dart';

typedef ArtQuery
    = Future<QueryResultForArt<T>> Function<T, U extends JA.JsonSerializable>(
        GraphQLQuery<T, U> query,
        {FetchPolicy fetchPolicy,
        dynamic option});

class ModelData<T, E> {
  String name;
  T state;
  E actions;

  static ModelData<T, E> factory<T, E>(String name, {T state, E actions}) {
    final _m = new ModelData();
    _m.name = name;
    _m.state = state;
    _m.actions = actions;
    return _m;
  }
}

typedef SetData<T> = dynamic Function(T);

class HelpAction<T> {
  T state;
  SetData<T> setData;
  ArtQuery query;
}

class ModelResult<T, E> {
  Map<String, StoreData> originStore;
  T state;
  E actions;
  HelpAction<T> helpAction;
  Function getLoad;
}

class StoreData<T, E> {
  String key;
  T state;
  E actions;
  List listenActions;

  static StoreData<T, E> factory<T, E>(ModelData<T, E> modelData) {
    final _m = new StoreData();
    _m.key = modelData.name;
    _m.state = modelData.state;
    _m.actions = modelData.actions;
    _m.listenActions = [];
    return _m;
  }
}

Map<String, StoreData> originStore = {
  'loadingData': StoreData()..state = Map<String, bool>(),
  'errorData': StoreData()..state = Map<String, dynamic>(),
};

ModelResult<T, E> useStoreModel<T, E>(ModelData<T, E> modelData) {
  final stateInUse = useState(new DateTime.now().millisecondsSinceEpoch);
  String key = modelData.name;
  if (originStore[key] == null) {
    originStore[key] = StoreData.factory(modelData);
  }
  T originState = originStore[key].state;
  useEffect(() {
    originStore[key].listenActions = [
      ...originStore[key].listenActions ?? [],
      stateInUse,
    ];
    return () {
      originStore[key].listenActions = originStore[key]
          .listenActions
          .where((v) => v.value != stateInUse.value).toList();
    };
  }, [key]);
  notice(data) {
    originStore[key].listenActions.forEach((element) {
      element.value = new DateTime.now().millisecondsSinceEpoch;
    });
  }

  setData(T data) {
    originStore[key].state = data;
    notice(data);
  }

  setLoad(GraphQLQuery query, bool flag) {
    originStore['loadingData']?.state[query.toString()] = flag;
    notice(null);
  }

  setError(GraphQLQuery query, dynamic err) {
    originStore['errorData']?.state[query.toString()] = err;
    notice(null);
  }

  query<T, U extends JA.JsonSerializable>(
    GraphQLQuery<T, U> query, {
    fetchPolicy,
    option,
  }) async {
    setLoad(query, true);
    final res = await artGraphqlQueryByType__Graphql(query)
        .catchError((err) => setError(query, err))
        .whenComplete(() => setLoad(query, false));
    return res;
  }

  bool getLoad(Type key) => originStore['loadingData']?.state['$key'] ?? false;

  return ModelResult()
    ..originStore = originStore
    ..getLoad = getLoad
    ..state = originState
    ..actions = modelData.actions
    ..helpAction = (HelpAction()
      ..state = originState
      ..query = query
      ..setData = setData);
}

void main() {}
