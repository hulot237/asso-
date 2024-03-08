// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CotisationDetailState extends Equatable {
  final Map<String, dynamic>? detailCotisation;
  final bool isLoading;
  final bool errorLoadDetailCotis;

  CotisationDetailState({
    this.detailCotisation,
    this.isLoading = false,
    this.errorLoadDetailCotis=false,
  });

  @override
  List<Object?> get props => [
        detailCotisation,
        isLoading,
        errorLoadDetailCotis,
      ];


  CotisationDetailState copyWith({
    Map<String, dynamic>? detailCotisation,
    bool? isLoading,
    bool? errorLoadDetailCotis,
  }) {
    return CotisationDetailState(
      detailCotisation: detailCotisation ?? this.detailCotisation,
      isLoading: isLoading ?? this.isLoading,
      errorLoadDetailCotis: errorLoadDetailCotis ?? this.errorLoadDetailCotis,
    );
  }
}
