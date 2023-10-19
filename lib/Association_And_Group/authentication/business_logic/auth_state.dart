import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final Map<String, dynamic>? loginInfo;

  AuthState({
    this.detailUser,
    this.loginInfo,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
    Map<String, dynamic>? logininfo
  }) {
    return AuthState(
      detailUser: detailuser,
      loginInfo: logininfo,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(detailUser: json['detailUser']);
  }
}
