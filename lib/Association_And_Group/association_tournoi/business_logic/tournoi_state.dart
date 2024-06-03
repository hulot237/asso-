// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class DetailTournoiCourantState extends Equatable {
  final Map<String, dynamic>? detailtournoiCourant;
  final Map<String, dynamic>? detailtournoiCourantHist;
  final Map<String, dynamic>? changeTournoi;
  // final List<dynamic>? allTournoiAss;
  final bool isLoading;

  DetailTournoiCourantState({
    this.detailtournoiCourant,
    this.detailtournoiCourantHist,
    this.changeTournoi,
    // this.allTournoiAss,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailtournoiCourant,
        detailtournoiCourantHist,
        changeTournoi,
        // allTournoiAss,
        isLoading,
      ];

  DetailTournoiCourantState copyWith({
    Map<String, dynamic>? detailtournoiCourant,
    Map<String, dynamic>? detailtournoiCourantHist,
    Map<String, dynamic>? changeTournoi,
    bool? isLoading,
  }) {
    return DetailTournoiCourantState(
      detailtournoiCourant: detailtournoiCourant ?? this.detailtournoiCourant,
      detailtournoiCourantHist: detailtournoiCourantHist ?? this.detailtournoiCourantHist,
      changeTournoi: changeTournoi ?? this.changeTournoi,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // factory DetailTournoiCourantState.fromJson(Map<String, dynamic> json) {
  //   return DetailTournoiCourantState(
  //     detailtournoiCourant: json['detailTournoiCourant']
  //   );
  // }
}
