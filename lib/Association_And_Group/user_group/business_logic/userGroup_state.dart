import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class UserGroupState extends Equatable {
  final List<UserGroupModel>? userGroup;
  final Map<String, dynamic>? userGroupDefault;

  UserGroupState({
    this.userGroup,
    this.userGroupDefault,
  });

  @override
  List<Object?> get props => [
        userGroup,
        userGroupDefault,
      ];

  UserGroupState copyWith({
    List<UserGroupModel>? usergroup,
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? usergroupdefault,
  }) {
    return UserGroupState(
      userGroup: usergroup,
      userGroupDefault: usergroupdefault,
    );
  }

  factory UserGroupState.fromJson(Map<String, dynamic> json) {
    return UserGroupState(
      userGroup: json['userGroup'],
      userGroupDefault: json['userGroupDefault']
    );
  }
}
