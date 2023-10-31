import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final Map<String, dynamic>? loginInfo;
  final Map<String, dynamic>? updateInfoUser;
    final bool isLoading;


  AuthState({
    this.detailUser,
    this.loginInfo,
    this.updateInfoUser,
        this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
        updateInfoUser,
                isLoading,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
    Map<String, dynamic>? logininfo,
    Map<String, dynamic>? updateinfouser,
        required bool isloading,
  }) {
    return AuthState(
      detailUser: detailuser,
      loginInfo: logininfo,
      updateInfoUser: updateinfouser,
            isLoading: isloading,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(detailUser: json['detailUser']);
  }
}
