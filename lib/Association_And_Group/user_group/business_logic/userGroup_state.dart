// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class UserGroupState extends Equatable {
  final List<dynamic>? userGroup;
  final InfoAssModel? changeAssData;
  final bool isLoading;
  final bool isLoadingChangeAss;


  UserGroupState({
    this.userGroup,
    this.changeAssData,
    this.isLoading = false,
    this.isLoadingChangeAss =false,
  });

  @override
  List<Object?> get props => [
        userGroup,
        changeAssData,
        isLoading,
        isLoadingChangeAss,
      ];

  UserGroupState copyWith({
    List<dynamic>? userGroup,
    InfoAssModel? changeAssData,
    bool? isLoading,
    bool? isLoadingChangeAss,
  }) {
    return UserGroupState(
      userGroup: userGroup ?? this.userGroup,
      changeAssData: changeAssData ?? this.changeAssData,
      isLoading: isLoading ?? this.isLoading,
      isLoadingChangeAss: isLoadingChangeAss ?? this.isLoadingChangeAss,
    );
  }

}
