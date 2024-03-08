// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SeanceState extends Equatable {
  final Map<String, dynamic>? detailSeance;
  final List<dynamic>? allSeanceAss;
  final bool isLoading;
  final bool errorLoadDetailSeance;


  SeanceState({
    this.detailSeance,
    this.allSeanceAss,
    this.isLoading = false,
    this.errorLoadDetailSeance = false,
  });

  @override
  List<Object?> get props => [
        detailSeance,
        allSeanceAss,
        isLoading,
        errorLoadDetailSeance,
      ];

  SeanceState copyWith({
    Map<String, dynamic>? detailSeance,
    List<dynamic>? allSeanceAss,
    bool? isLoading,
    bool? errorLoadDetailSeance,
  }) {
    return SeanceState(
      detailSeance: detailSeance ?? this.detailSeance,
      allSeanceAss: allSeanceAss ?? this.allSeanceAss,
      isLoading: isLoading ?? this.isLoading,
      errorLoadDetailSeance: errorLoadDetailSeance ?? this.errorLoadDetailSeance,
    );
  }



}
