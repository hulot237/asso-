import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class DetailTournoiCourantState extends Equatable {
  final Map<String, dynamic>? detailtournoiCourant;
  final Map<String, dynamic>? changeTournoi;
  // final List<dynamic>? allTournoiAss;
  final bool isLoading;

  DetailTournoiCourantState({
    this.detailtournoiCourant,
    this.changeTournoi,
    // this.allTournoiAss,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailtournoiCourant,
        changeTournoi,
        // allTournoiAss,
        isLoading,
      ];

  DetailTournoiCourantState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailtournoicourant,
    Map<String, dynamic>? changetournoi,
    // List<dynamic>? alltournoiass,
    required bool isloading,
  }) {
    return DetailTournoiCourantState(
      detailtournoiCourant: detailtournoicourant,
      changeTournoi: changetournoi,
      // allTournoiAss: alltournoiass,
      isLoading: isloading,
    );
  }

  // factory DetailTournoiCourantState.fromJson(Map<String, dynamic> json) {
  //   return DetailTournoiCourantState(
  //     detailtournoiCourant: json['detailTournoiCourant']
  //   );
  // }
}
