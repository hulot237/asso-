// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';

class NotificationState extends Equatable {
  final String? tokenNotification;
  final List<NotificationModel>? notifications;
  final bool isLoading;
  final bool isLoadingNomberNotif;
  final String? messageError;
  final int? nomberNotif;
  final bool errorLoadNotif;
  

  NotificationState({
    this.tokenNotification,
    this.notifications,
    this.isLoading = false,
    this.isLoadingNomberNotif = false,
    this.errorLoadNotif = false,
    this.messageError,
    this.nomberNotif,
  });

  @override
  List<Object?> get props => [
        tokenNotification,
        isLoading,
        notifications,
        messageError,
        nomberNotif,
        errorLoadNotif
      ];

  NotificationState copyWith({
    String? tokenNotification,
    List<NotificationModel>? notifications,
    bool? isLoading,
    bool? isLoadingNomberNotif,
    String? messageError,
    int? nomberNotif,
    bool? errorLoadNotif,
  }) {
    return NotificationState(
      tokenNotification: tokenNotification ?? this.tokenNotification,
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      isLoadingNomberNotif: isLoadingNomberNotif ?? this.isLoadingNomberNotif,
      messageError: messageError ?? this.messageError,
      nomberNotif: nomberNotif ?? this.nomberNotif,
      errorLoadNotif: errorLoadNotif ?? this.errorLoadNotif,
    );
  }

}
