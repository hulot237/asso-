// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/collecte_model.dart';

class CotisationState extends Equatable {
  final List<dynamic>? allCotisationAss;
  final bool isLoading;
  final CollecteModel? collectes;

  CotisationState({
    this.allCotisationAss,
    this.isLoading = false,
    this.collectes,
  });

  @override
  List<Object?> get props => [
        allCotisationAss,
        isLoading,
        collectes
      ];

  CotisationState copyWith({
    List<dynamic>? allCotisationAss,
    bool? isLoading,
    CollecteModel? collectes,
  }) {
    return CotisationState(
      allCotisationAss: allCotisationAss ?? this.allCotisationAss,
      isLoading: isLoading ?? this.isLoading,
      collectes: collectes ?? this.collectes,
    );
  }

}
