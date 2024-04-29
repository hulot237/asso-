// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_model.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;
  final AuthModel? loginInfo;
  final bool isLoading;
  final bool? isTrueNomber;
  final bool? isLoadingDetailUser;
  final bool errorLoading;
  final bool successLoading;
  final String? message;
  final String? getUid;
  final String? dataCookies;
  final bool errorLoadDetailAuth;

  AuthState({
    this.detailUser,
    this.loginInfo,
    this.isLoading = false,
    this.isTrueNomber,
    this.isLoadingDetailUser,
    this.errorLoading = false,
    this.successLoading = false,
    this.message,
    this.getUid,
    this.errorLoadDetailAuth = false,
    this.dataCookies,
  });

  @override
  List<Object?> get props => [
        detailUser,
        loginInfo,
        isLoading,
        isTrueNomber,
        isLoadingDetailUser,
        errorLoading,
        message,
        successLoading,
        getUid,
        errorLoadDetailAuth,
        dataCookies,
      ];


  AuthState copyWith({
    Map<String, dynamic>? detailUser,
    AuthModel? loginInfo,
    bool? isLoading,
    bool? isTrueNomber,
    bool? isLoadingDetailUser,
    bool? errorLoading,
    bool? successLoading,
    String? message,
    String? getUid,
    String? dataCookies,
    bool? errorLoadDetailAuth,
  }) {
    return AuthState(
      detailUser: detailUser ?? this.detailUser,
      loginInfo: loginInfo ?? this.loginInfo,
      isLoading: isLoading ?? this.isLoading,
      isTrueNomber: isTrueNomber ?? this.isTrueNomber,
      isLoadingDetailUser: isLoadingDetailUser ?? this.isLoadingDetailUser,
      errorLoading: errorLoading ?? this.errorLoading,
      successLoading: successLoading ?? this.successLoading,
      message: message ?? this.message,
      getUid: getUid ?? this.getUid,
      dataCookies: dataCookies ?? this.dataCookies,
      errorLoadDetailAuth: errorLoadDetailAuth ?? this.errorLoadDetailAuth,
    );
  }
}
