import 'package:equatable/equatable.dart';

class ContributionState extends Equatable {
  final bool isLoadingContibutionTontine;
  final Map<dynamic,dynamic>? detailContributionTontine;
  

  ContributionState({
    this.detailContributionTontine,
    this.isLoadingContibutionTontine=false,
  });

  @override
  List<Object?> get props => [
        isLoadingContibutionTontine,
        detailContributionTontine,
      ];

  ContributionState copyWith({
    Map<dynamic, dynamic>? detailcontributiontontine,
    required bool isloadingcontibutionTontine
  }) {
    return ContributionState(
      isLoadingContibutionTontine: isloadingcontibutionTontine,
      detailContributionTontine: detailcontributiontontine,
    );
  }

}
