import 'package:equatable/equatable.dart';

class AuthUpdateState extends Equatable {
  final Map<String, dynamic>? updateInfoUser;
  final bool isLoading;

  AuthUpdateState({
    this.updateInfoUser,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        updateInfoUser,
        isLoading,
      ];

  AuthUpdateState copyWith({
    Map<String, dynamic>? updateinfouser,
    required bool isloading,
  }) {
    return AuthUpdateState(
      updateInfoUser: updateinfouser,
      isLoading: isloading,
    );
  }

}
