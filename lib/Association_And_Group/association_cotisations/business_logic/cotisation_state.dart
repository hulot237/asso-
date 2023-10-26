import 'package:equatable/equatable.dart';

class CotisationState extends Equatable {
  final Map<String, dynamic>? detailCotisation;
  final List<dynamic>? allCotisationAss;
  final bool isLoading;

  CotisationState({
    this.detailCotisation,
    this.allCotisationAss,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailCotisation,
        allCotisationAss,
        isLoading,
      ];

  CotisationState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailcotisation,
    List<dynamic>? allcotisationAss,
    required bool isloading,
  }) {
    return CotisationState(
      detailCotisation: detailcotisation,
      allCotisationAss: allcotisationAss,
      isLoading: isloading,
    );
  }

}
