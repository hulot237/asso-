import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';

class CompteState extends Equatable {
  final List<CompteModel>? allCompteAss;
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
    List<CompteModel>? allcompteAss,
    required bool isloading,
  }) {
    return CompteState(
      allCompteAss: allcompteAss,
      isLoading: isloading,
    );
  }
}
