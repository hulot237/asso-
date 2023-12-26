import 'package:equatable/equatable.dart';

class PayementState extends Equatable {
  final bool? retraitApprove;
  final bool isLoading;

  PayementState({
    this.retraitApprove,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        retraitApprove,
        isLoading,
      ];

  PayementState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    bool? retraitapprove,
    required bool isloading,
  }) {
    return PayementState(
      retraitApprove: retraitapprove,
      isLoading: isloading,
    );
  }

}


