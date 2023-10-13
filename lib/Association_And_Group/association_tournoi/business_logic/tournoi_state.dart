import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class DetailTournoiCourantState extends Equatable {
  final Map<String, dynamic>? detailtournoiCourant;

  DetailTournoiCourantState({
    this.detailtournoiCourant,
  });

  @override
  List<Object?> get props => [
        detailtournoiCourant,
      ];

  DetailTournoiCourantState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailtournoicourant,
  }) {
    return DetailTournoiCourantState(
      detailtournoiCourant: detailtournoicourant,
    );
  }

  factory DetailTournoiCourantState.fromJson(Map<String, dynamic> json) {
    return DetailTournoiCourantState(
      detailtournoiCourant: json['detailTournoiCourant']
    );
  }
}
