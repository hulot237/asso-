// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/collecte_model.dart';

class CotisationState extends Equatable {
  final List<dynamic>? allCotisationAss;
  final bool isLoadingCotis;
  final bool isLoadingCollect;
  final CollecteModel? collectes;

  CotisationState({
    this.allCotisationAss,
    this.isLoadingCotis = false,
    this.isLoadingCollect = false,
    this.collectes,
  });

  @override
  List<Object?> get props => [
        allCotisationAss,
        isLoadingCotis,
        isLoadingCollect,
        collectes
      ];

  CotisationState copyWith({
    List<dynamic>? allCotisationAss,
    bool? isLoadingCotis,
    bool? isLoadingCollect,
    CollecteModel? collectes,
  }) {
    return CotisationState(
      allCotisationAss: allCotisationAss ?? this.allCotisationAss,
      isLoadingCotis: isLoadingCotis ?? this.isLoadingCotis,
      isLoadingCollect: isLoadingCollect ?? this.isLoadingCollect,
      collectes: collectes ?? this.collectes,
    );
  }

}
