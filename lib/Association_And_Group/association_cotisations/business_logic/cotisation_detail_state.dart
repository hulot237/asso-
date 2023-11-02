import 'package:equatable/equatable.dart';

class CotisationDetailState extends Equatable {
  final Map<String, dynamic>? detailCotisation;
  final bool isLoading;

  CotisationDetailState({
    this.detailCotisation,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailCotisation,
        isLoading,
      ];

  CotisationDetailState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? detailcotisation,
    required bool isloading,
  }) {
    return CotisationDetailState(
      detailCotisation: detailcotisation,
      isLoading: isloading,
    );
  }

}
