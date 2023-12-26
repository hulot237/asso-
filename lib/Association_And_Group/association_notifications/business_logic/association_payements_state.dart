
import 'package:equatable/equatable.dart';

class tokenNotificationState extends Equatable {
  final String? tokenNotification;
  

  tokenNotificationState({
    this.tokenNotification,
  });

  @override
  List<Object?> get props => [
        tokenNotification,
      ];

  tokenNotificationState copyWith({
    // List<UserGroupCourantModel>? userGroupDefault,
    String? tokennotification,
  }) {
    return tokenNotificationState(
      tokenNotification: tokennotification,
    );
  }

}
