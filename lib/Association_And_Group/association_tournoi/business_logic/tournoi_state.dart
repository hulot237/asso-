// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DetailTournoiCourantState extends Equatable {
  final Map<String, dynamic>? detailtournoiCourant;
  final Map<String, dynamic>? detailtournoiCourantHist;
  final Map<String, dynamic>? changeTournoi;
  // final List<dynamic>? allTournoiAss;
  final bool isLoading;
  final bool isLoadingHist;

  DetailTournoiCourantState({
    this.detailtournoiCourant,
    this.detailtournoiCourantHist,
    this.changeTournoi,
    // this.allTournoiAss,
    this.isLoading = false,
    this.isLoadingHist = false,
  });

  @override
  List<Object?> get props => [
        detailtournoiCourant,
        detailtournoiCourantHist,
        changeTournoi,
        // allTournoiAss,
        isLoading,
        isLoadingHist,
      ];

  DetailTournoiCourantState copyWith({
    Map<String, dynamic>? detailtournoiCourant,
    Map<String, dynamic>? detailtournoiCourantHist,
    Map<String, dynamic>? changeTournoi,
    bool? isLoading,
    bool? isLoadingHist,
  }) {
    return DetailTournoiCourantState(
      detailtournoiCourant: detailtournoiCourant ?? this.detailtournoiCourant,
      detailtournoiCourantHist: detailtournoiCourantHist ?? this.detailtournoiCourantHist,
      changeTournoi: changeTournoi ?? this.changeTournoi,
      isLoading: isLoading ?? this.isLoading,
      isLoadingHist: isLoadingHist ?? this.isLoadingHist,
    );
  }

  // factory DetailTournoiCourantState.fromJson(Map<String, dynamic> json) {
  //   return DetailTournoiCourantState(
  //     detailtournoiCourant: json['detailTournoiCourant']
  //   );
  // }
}
