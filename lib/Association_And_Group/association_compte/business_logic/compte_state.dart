import 'package:equatable/equatable.dart';

class CompteState extends Equatable {
  final List<dynamic>? allCompteAss;
  final bool isLoading;

  CompteState({
    this.allCompteAss,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        allCompteAss,
        isLoading,
      ];

  CompteState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    List<dynamic>? allcompteAss,
    required bool isloading,
  }) {
    return CompteState(
      allCompteAss: allcompteAss,
      isLoading: isloading,
    );
  }
}
