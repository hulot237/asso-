import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final Map<String, dynamic>? loginInfo;
  final bool isLoading;
  final bool? isTrueNomber;
  final bool?isLoadingDetailUser;

  AuthState({
    this.detailUser,
    this.loginInfo,
    this.isLoading = false,
    this.isTrueNomber,
    this.isLoadingDetailUser,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
        isLoading,
        isTrueNomber,
        isLoadingDetailUser,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
    Map<String, dynamic>? logininfo,
    required bool isloading,
    bool? istruenomber,
    required bool isloadingdetailuser,
  }) {
    return AuthState(
      detailUser: detailuser,
      loginInfo: logininfo,
      isLoading: isloading,
      isTrueNomber: istruenomber,
isLoadingDetailUser: isloadingdetailuser,
    );
  }
}
