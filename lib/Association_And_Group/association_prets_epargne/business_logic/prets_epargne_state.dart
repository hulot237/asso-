// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';

class PretEpargneState extends Equatable {
  final Map<String, dynamic>? epargne;
  final bool isLoadingEpargne;
  final bool isLoadingNomberNotif;
  final String? messageError;
  final int? nomberNotif;
  

  PretEpargneState({
    this.epargne,
    this.isLoadingEpargne = false,
    this.isLoadingNomberNotif = false,
    this.messageError,
    this.nomberNotif,
  });

  @override
  List<Object?> get props => [
        epargne,
        isLoadingEpargne,
        messageError,
        nomberNotif,
      ];

  PretEpargneState copyWith({
    Map<String, dynamic>? epargne,
    bool? isLoadingEpargne,
    bool? isLoadingNomberNotif,
    String? messageError,
    int? nomberNotif,
  }) {
    return PretEpargneState(
      epargne: epargne ?? this.epargne,
      isLoadingEpargne: isLoadingEpargne ?? this.isLoadingEpargne,
      isLoadingNomberNotif: isLoadingNomberNotif ?? this.isLoadingNomberNotif,
      messageError: messageError ?? this.messageError,
      nomberNotif: nomberNotif ?? this.nomberNotif,
    );
  }

}
