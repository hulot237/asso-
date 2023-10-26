import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class UserGroupState extends Equatable {
  final List<UserGroupModel>? userGroup;
  final Map<String, dynamic>? userGroupDefault;
  final Map<String, dynamic>? ChangeAssData;
  final bool isLoading;

  UserGroupState({
    this.userGroup,
    this.userGroupDefault,
    this.ChangeAssData,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        userGroup,
        userGroupDefault,
        ChangeAssData,
        isLoading,
      ];

  UserGroupState copyWith({
    List<UserGroupModel>? usergroup,
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? usergroupdefault,
    Map<String, dynamic>? changeassdata,
    required bool isloading,
  }) {
    return UserGroupState(
      userGroup: usergroup,
      userGroupDefault: usergroupdefault,
      ChangeAssData: changeassdata,
      isLoading: isloading,
    );
  }

  factory UserGroupState.fromJson(Map<String, dynamic> json) {
    return UserGroupState(
        userGroup: json['userGroup'],
        userGroupDefault: json['userGroupDefault']);
  }
}
