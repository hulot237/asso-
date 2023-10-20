import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final Map<String, dynamic>? loginInfo;
  final Map<String, dynamic>? updateInfoUser;


  AuthState({
    this.detailUser,
    this.loginInfo,
    this.updateInfoUser,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
        updateInfoUser,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
    Map<String, dynamic>? logininfo,
    Map<String, dynamic>? updateinfouser,
  }) {
    return AuthState(
      detailUser: detailuser,
      loginInfo: logininfo,
      updateInfoUser: updateinfouser,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(detailUser: json['detailUser']);
  }
}
