// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';

class PretEpargneState extends Equatable {
  final Map<String, dynamic>? epargne;
  final bool isLoadingEpargne;
    final Map<String, dynamic>? pret;
  final bool isLoadingPret;
  final bool isLoadingDetailEpargne;
  final String? messageError;
  final List<dynamic>? detailEpargne;
  final List<dynamic>? detailPret;
  final bool isLoadingDetailPret;


  PretEpargneState({
    this.epargne,
    this.pret,
    this.isLoadingPret = false,
    this.isLoadingEpargne = false,
    this.isLoadingDetailEpargne = false,
    this.messageError,
    this.detailEpargne,
    this.detailPret,
    this.isLoadingDetailPret= false,
  });

  @override
  List<Object?> get props => [
        epargne,
        isLoadingEpargne,
        isLoadingDetailEpargne,
        messageError,
        detailEpargne,
        pret,
        isLoadingPret,
        detailPret,
        isLoadingDetailPret,
      ];

  PretEpargneState copyWith({
    Map<String, dynamic>? epargne,
    bool? isLoadingEpargne,
    Map<String, dynamic>? pret,
    bool? isLoadingPret,
    bool? isLoadingDetailEpargne,
    String? messageError,
    List<dynamic>? detailEpargne,
    List<dynamic>? detailPret,
    bool? isLoadingDetailPret,
  }) {
    return PretEpargneState(
      epargne: epargne ?? this.epargne,
      isLoadingEpargne: isLoadingEpargne ?? this.isLoadingEpargne,
      pret: pret ?? this.pret,
      isLoadingPret: isLoadingPret ?? this.isLoadingPret,
      isLoadingDetailEpargne: isLoadingDetailEpargne ?? this.isLoadingDetailEpargne,
      messageError: messageError ?? this.messageError,
      detailEpargne: detailEpargne ?? this.detailEpargne,
      detailPret: detailPret ?? this.detailPret,
      isLoadingDetailPret: isLoadingDetailPret ?? this.isLoadingDetailPret,
    );
  }
}
