import 'package:equatable/equatable.dart';

class SeanceState extends Equatable {
  final Map<String, dynamic>? detailSeance;

  SeanceState({
    this.detailSeance,
  });

  @override
  List<Object?> get props => [
        detailSeance,
      ];

  SeanceState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailseance,
  }) {
    return SeanceState(
      detailSeance: detailseance,
    );
  }



}
