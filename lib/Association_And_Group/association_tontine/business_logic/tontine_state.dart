// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TontineState extends Equatable {
  final List<dynamic>? detailTontine;
  final bool isLoading;
  final bool errorLoadDetailTontine;
  

  TontineState({
    this.detailTontine,
    this.isLoading = false,
    this.errorLoadDetailTontine = false,
  });

  @override
  List<Object?> get props => [
        detailTontine,
        isLoading,
        errorLoadDetailTontine,
      ];

  TontineState copyWith({
    List<dynamic>? detailTontine,
    bool? isLoading,
    bool? errorLoadDetailTontine ,
  }) {
    return TontineState(
      detailTontine: detailTontine ?? this.detailTontine,
      isLoading: isLoading ?? this.isLoading,
      errorLoadDetailTontine: errorLoadDetailTontine ?? this.errorLoadDetailTontine,
    );
  }

}
