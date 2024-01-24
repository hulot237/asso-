import 'package:equatable/equatable.dart';

class RecentEventState extends Equatable {
  final Map<String, dynamic>? allRecentEvent;
  final bool isLoading;

  RecentEventState({
    this.allRecentEvent,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        allRecentEvent,
        isLoading,
      ];

  RecentEventState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    Map<String, dynamic>? allrecentEvent,
    required bool isloading,
  }) {
    return RecentEventState(
      allRecentEvent: allrecentEvent,
      isLoading: isloading,
    );
  }

}
