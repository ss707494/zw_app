import 'package:zw_app/common/storeModel/storeModel.dart';
import 'package:zw_app/type__graphql/art_graphql/art_graphql_query.dart';

class UserCenterState {
  UserCenter$Query$User user;
}

class UserCenterActions {
  getData(HelpAction<UserCenterState> h) => () async {
    final res = await h.query(UserCenterQuery());
    h.setData(h.state..user = res?.data?.oneUser);
  };
}

ModelData<UserCenterState, UserCenterActions> userCenterModelDate = ModelData()
  ..name = 'UserCenterModelDate'
  ..actions = UserCenterActions()
  ..state = UserCenterState();
