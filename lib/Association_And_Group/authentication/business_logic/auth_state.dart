import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final Map<String, dynamic>? detailUser;

  AuthState({
    this.detailUser,
  });

  @override
  List<Object?> get props => [
        detailUser,
      ];

  AuthState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailuser,
  }) {
    return AuthState(
      detailUser: detailuser,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(detailUser: json['detailUser']);
  }
}
