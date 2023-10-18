import 'package:equatable/equatable.dart';

class CotisationState extends Equatable {
  final Map<String, dynamic>? detailCotisation;
  final List<dynamic>? allCotisationAss;

  CotisationState({
    this.detailCotisation,
    this.allCotisationAss,
  });

  @override
  List<Object?> get props => [
        detailCotisation,
        allCotisationAss,
      ];

  CotisationState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailcotisation,
    List<dynamic>? allcotisationAss,
  }) {
    return CotisationState(
      detailCotisation: detailcotisation,
      allCotisationAss: allcotisationAss,
    );
  }

  factory CotisationState.fromJson(Map<String, dynamic> json) {
    return CotisationState(detailCotisation: json['detailCotisation']);
  }
}
