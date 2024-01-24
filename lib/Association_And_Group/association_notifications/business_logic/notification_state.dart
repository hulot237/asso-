// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';

class NotificationState extends Equatable {
  final String? tokenNotification;
  final List<NotificationModel>? notifications;
  final bool isLoading;
  final String? messageError;
  

  NotificationState({
    this.tokenNotification,
    this.notifications,
    this.isLoading = false,
    this.messageError,
  });

  @override
  List<Object?> get props => [
        tokenNotification,
        isLoading,
        notifications,
        messageError,
      ];

  NotificationState copyWith({
    String? tokenNotification,
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? messageError,
  }) {
    return NotificationState(
      tokenNotification: tokenNotification ?? this.tokenNotification,
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      messageError: messageError ?? this.messageError,
    );
  }

}
