import 'package:equatable/equatable.dart';

class ContributionState extends Equatable {
  final bool isLoadingContibutionTontine;
  final Map<dynamic,dynamic>? detailContributionTontine;
    final bool errorLoadDetailCotis;
  

  ContributionState({
    this.detailContributionTontine,
    this.isLoadingContibutionTontine=false,
      this.errorLoadDetailCotis=false,
  });

  @override
  List<Object?> get props => [
        isLoadingContibutionTontine,
        detailContributionTontine,
        errorLoadDetailCotis,
      ];

  ContributionState copyWith({
    Map<dynamic, dynamic>? detailcontributiontontine,
    required bool isloadingcontibutionTontine,
      bool? errorLoadDetailCotis,
  }) {
    return ContributionState(
      isLoadingContibutionTontine: isloadingcontibutionTontine,
      detailContributionTontine: detailcontributiontontine,
       errorLoadDetailCotis: errorLoadDetailCotis ?? this.errorLoadDetailCotis,
    );
  }

}
