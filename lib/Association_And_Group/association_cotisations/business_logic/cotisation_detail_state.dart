// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/participant_model.dart';

class CotisationDetailState extends Equatable {
  final Map<String, dynamic>? detailCotisation;
  final List<Participants>? participants;
  final bool isLoading;
  final bool errorLoadDetailCotis;

  CotisationDetailState({
    this.detailCotisation,
    this.participants,
    this.isLoading = false,
    this.errorLoadDetailCotis=false,
  });

  @override
  List<Object?> get props => [
        detailCotisation,
        participants,
        isLoading,
        errorLoadDetailCotis,
      ];


  CotisationDetailState copyWith({
    Map<String, dynamic>? detailCotisation,
    List<Participants>? participants,
    bool? isLoading,
    bool? errorLoadDetailCotis,
  }) {
    return CotisationDetailState(
      detailCotisation: detailCotisation ?? this.detailCotisation,
      participants: participants ?? this.participants,
      isLoading: isLoading ?? this.isLoading,
      errorLoadDetailCotis: errorLoadDetailCotis ?? this.errorLoadDetailCotis,
    );
  }
}
