import 'package:equatable/equatable.dart';

class CompteState extends Equatable {
  final List<dynamic>? allCompteAss;

  CompteState({
    this.allCompteAss,
  });

  @override
  List<Object?> get props => [
        allCompteAss,
      ];

  CompteState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    List<dynamic>? allcompteAss,
  }) {
    return CompteState(
      allCompteAss: allcompteAss,
    );
  }

  factory CompteState.fromJson(Map<String, dynamic> json) {
    return CompteState(allCompteAss: json['allCompteAss']);
  }
}
