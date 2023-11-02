import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final Map<String, dynamic>? loginInfo;
  final bool isLoading;
  final bool? isTrueNomber;

  AuthState({
    this.detailUser,
    this.loginInfo,
    this.isLoading = false,
    this.isTrueNomber,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
        isLoading,
        isTrueNomber,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
    Map<String, dynamic>? logininfo,
    required bool isloading,
    bool? istruenomber,
  }) {
    return AuthState(
      detailUser: detailuser,
      loginInfo: logininfo,
      isLoading: isloading,
      isTrueNomber: istruenomber,

    );
  }
}
