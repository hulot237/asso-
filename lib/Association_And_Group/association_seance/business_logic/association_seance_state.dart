import 'package:equatable/equatable.dart';

class SeanceState extends Equatable {
  final Map<String, dynamic>? detailSeance;
  final List<dynamic>? allSeanceAss;
  final bool isLoading;


  SeanceState({
    this.detailSeance,
    this.allSeanceAss,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailSeance,
        allSeanceAss,
        isLoading,
      ];

  SeanceState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailseance,
    List<dynamic>? allseanceass,
    required bool isloading,
  }) {
    return SeanceState(
      detailSeance: detailseance,
      allSeanceAss: allseanceass,
      isLoading: isloading,
    );
  }



}
