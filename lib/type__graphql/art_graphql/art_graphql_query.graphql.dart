// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'art_graphql_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class PromoCodeList$Query$PromoCode with EquatableMixin {
  PromoCodeList$Query$PromoCode();

  factory PromoCodeList$Query$PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeList$Query$PromoCodeFromJson(json);

  String id;

  String name;

  int createTime;

  @override
  List<Object> get props => [id, name, createTime];
  Map<String, dynamic> toJson() => _$PromoCodeList$Query$PromoCodeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PromoCodeList$Query with EquatableMixin {
  PromoCodeList$Query();

  factory PromoCodeList$Query.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeList$QueryFromJson(json);

  List<PromoCodeList$Query$PromoCode> promoCodeList;

  @override
  List<Object> get props => [promoCodeList];
  Map<String, dynamic> toJson() => _$PromoCodeList$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PromoCodeList$PromoCodeItemInput with EquatableMixin {
  PromoCodeList$PromoCodeItemInput(
      {this.code,
      this.createTime,
      this.discountAmount,
      this.discountCondition,
      this.discountConditionAmount,
      this.discountType,
      this.effectiveDateEnd,
      this.effectiveDateStart,
      this.id,
      this.imgUrl,
      this.isDelete,
      this.isDisable,
      this.name,
      this.productCategory,
      this.promoCodeType,
      this.remark,
      this.reuseTimes,
      this.title,
      this.updateTime});

  factory PromoCodeList$PromoCodeItemInput.fromJson(
          Map<String, dynamic> json) =>
      _$PromoCodeList$PromoCodeItemInputFromJson(json);

  String code;

  int createTime;

  double discountAmount;

  String discountCondition;

  double discountConditionAmount;

  String discountType;

  int effectiveDateEnd;

  int effectiveDateStart;

  String id;

  String imgUrl;

  double isDelete;

  double isDisable;

  String name;

  String productCategory;

  String promoCodeType;

  String remark;

  double reuseTimes;

  String title;

  int updateTime;

  @override
  List<Object> get props => [
        code,
        createTime,
        discountAmount,
        discountCondition,
        discountConditionAmount,
        discountType,
        effectiveDateEnd,
        effectiveDateStart,
        id,
        imgUrl,
        isDelete,
        isDisable,
        name,
        productCategory,
        promoCodeType,
        remark,
        reuseTimes,
        title,
        updateTime
      ];
  Map<String, dynamic> toJson() =>
      _$PromoCodeList$PromoCodeItemInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PromoCodeListArguments extends JsonSerializable with EquatableMixin {
  PromoCodeListArguments({this.data});

  factory PromoCodeListArguments.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeListArgumentsFromJson(json);

  final PromoCodeList$PromoCodeItemInput data;

  @override
  List<Object> get props => [data];
  Map<String, dynamic> toJson() => _$PromoCodeListArgumentsToJson(this);
}

class PromoCodeListQuery
    extends GraphQLQuery<PromoCodeList$Query, PromoCodeListArguments> {
  PromoCodeListQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'promoCodeList'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'data')),
              type: NamedTypeNode(
                  name: NameNode(value: 'PromoCodeItemInput'),
                  isNonNull: false),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'promoCodeList'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'promoCodeItemInput'),
                    value: VariableNode(name: NameNode(value: 'data')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'createTime'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'promoCodeList';

  @override
  final PromoCodeListArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  PromoCodeList$Query parse(Map<String, dynamic> json) =>
      PromoCodeList$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TestLongApi$Query with EquatableMixin {
  TestLongApi$Query();

  factory TestLongApi$Query.fromJson(Map<String, dynamic> json) =>
      _$TestLongApi$QueryFromJson(json);

  String testLongApi;

  @override
  List<Object> get props => [testLongApi];
  Map<String, dynamic> toJson() => _$TestLongApi$QueryToJson(this);
}

class TestLongApiQuery
    extends GraphQLQuery<TestLongApi$Query, JsonSerializable> {
  TestLongApiQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'testLongApi'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'testLongApi'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'testLongApi';

  @override
  List<Object> get props => [document, operationName];
  @override
  TestLongApi$Query parse(Map<String, dynamic> json) =>
      TestLongApi$Query.fromJson(json);
}

mixin UserCenter$UserMixin {
  String id;
  String name;
  int createTime;
  int updateTime;
  double isDelete;
  double type;
  double orderCoinNextMonth;
  double orderCoinCurrentMonth;
  double orderAmountCurrentYear;
}

@JsonSerializable(explicitToJson: true)
class UserCenter$Query$User$UserInfo with EquatableMixin {
  UserCenter$Query$User$UserInfo();

  factory UserCenter$Query$User$UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserCenter$Query$User$UserInfoFromJson(json);

  String name;

  String phone;

  String email;

  @override
  List<Object> get props => [name, phone, email];
  Map<String, dynamic> toJson() => _$UserCenter$Query$User$UserInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserCenter$Query$User with EquatableMixin, UserCenter$UserMixin {
  UserCenter$Query$User();

  factory UserCenter$Query$User.fromJson(Map<String, dynamic> json) =>
      _$UserCenter$Query$UserFromJson(json);

  UserCenter$Query$User$UserInfo userInfo;

  @override
  List<Object> get props => [
        id,
        name,
        createTime,
        updateTime,
        isDelete,
        type,
        orderCoinNextMonth,
        orderCoinCurrentMonth,
        orderAmountCurrentYear,
        userInfo
      ];
  Map<String, dynamic> toJson() => _$UserCenter$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserCenter$Query with EquatableMixin {
  UserCenter$Query();

  factory UserCenter$Query.fromJson(Map<String, dynamic> json) =>
      _$UserCenter$QueryFromJson(json);

  UserCenter$Query$User oneUser;

  @override
  List<Object> get props => [oneUser];
  Map<String, dynamic> toJson() => _$UserCenter$QueryToJson(this);
}

class UserCenterQuery extends GraphQLQuery<UserCenter$Query, JsonSerializable> {
  UserCenterQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    FragmentDefinitionNode(
        name: NameNode(value: 'User'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'createTime'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'updateTime'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'isDelete'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'type'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'orderCoinNextMonth'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'orderCoinCurrentMonth'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'orderAmountCurrentYear'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'userCenter'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'oneUser'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'User'), directives: []),
                FieldNode(
                    name: NameNode(value: 'userInfo'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'phone'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'email'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'userCenter';

  @override
  List<Object> get props => [document, operationName];
  @override
  UserCenter$Query parse(Map<String, dynamic> json) =>
      UserCenter$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RefreshToken$Query$AuthBody with EquatableMixin {
  RefreshToken$Query$AuthBody();

  factory RefreshToken$Query$AuthBody.fromJson(Map<String, dynamic> json) =>
      _$RefreshToken$Query$AuthBodyFromJson(json);

  String token;

  String refreshtoken;

  @override
  List<Object> get props => [token, refreshtoken];
  Map<String, dynamic> toJson() => _$RefreshToken$Query$AuthBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshToken$Query with EquatableMixin {
  RefreshToken$Query();

  factory RefreshToken$Query.fromJson(Map<String, dynamic> json) =>
      _$RefreshToken$QueryFromJson(json);

  RefreshToken$Query$AuthBody refreshToken;

  @override
  List<Object> get props => [refreshToken];
  Map<String, dynamic> toJson() => _$RefreshToken$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokenArguments extends JsonSerializable with EquatableMixin {
  RefreshTokenArguments({@required this.refreshToken});

  factory RefreshTokenArguments.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenArgumentsFromJson(json);

  final String refreshToken;

  @override
  List<Object> get props => [refreshToken];
  Map<String, dynamic> toJson() => _$RefreshTokenArgumentsToJson(this);
}

class RefreshTokenQuery
    extends GraphQLQuery<RefreshToken$Query, RefreshTokenArguments> {
  RefreshTokenQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'refreshToken'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'refreshToken')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'refreshToken'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'refreshtoken'),
                    value: VariableNode(name: NameNode(value: 'refreshToken')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'token'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'refreshtoken'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'refreshToken';

  @override
  final RefreshTokenArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  RefreshToken$Query parse(Map<String, dynamic> json) =>
      RefreshToken$Query.fromJson(json);
}
