class VersemenModel {
  int? id;
  String? sourceName;
  String? sourceId;
  String? sourceAmount;
  String? extraFiltre;
  String? amount;
  String? balanceAfter;
  String? balanceRemaining;
  String? currency;
  int? isVersementFinished;
  String? status;
  String? versementBalance;
  int? assMembreId;
  String? createdAt;
  String? updatedAt;
  List<TransanctionsModel>? transanctions;

  VersemenModel(
      {this.id,
      this.sourceName,
      this.sourceId,
      this.sourceAmount,
      this.extraFiltre,
      this.amount,
      this.balanceAfter,
      this.balanceRemaining,
      this.currency,
      this.isVersementFinished,
      this.status,
      this.versementBalance,
      this.assMembreId,
      this.createdAt,
      this.updatedAt,
      this.transanctions});

  VersemenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceName = json['source_name'];
    sourceId = json['source_id'];
    sourceAmount = json['source_amount'];
    extraFiltre = json['extra_filtre'];
    amount = json['amount'];
    balanceAfter = json['balance_after'];
    balanceRemaining = json['balance_remaining'];
    currency = json['currency'];
    isVersementFinished = json['is_versement_finished'];
    status = json['status'];
    versementBalance = json['versement_balance'];
    assMembreId = json['ass_membre_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transanctions = json['transanctions'] != null ? (json['transanctions'] as List).map((e) => TransanctionsModel.fromJson(e)).toList(): null;
  }
}




class TransanctionsModel {
  int? id;
  int? assCotisationId;
  int? assMembreId;
  int? assCompteId;
  int? assInfosVersementId;
  String? mode;
  int? userGroupId;
  String? adminId;
  String? adminName;
  String? extraFiltre;
  String? reference;
  String? description;
  String? amount;
  String? sourceName;
  String? sourceId;
  String? currency;
  String? status;
  String? fees;
  String? amountCurrency;
  String? balanceAfter;
  String? paymentType;
  String? type;
  String? createdAt;
  String? updatedAt;

  TransanctionsModel(
      {this.id,
      this.assCotisationId,
      this.assMembreId,
      this.assCompteId,
      this.assInfosVersementId,
      this.mode,
      this.userGroupId,
      this.adminId,
      this.adminName,
      this.extraFiltre,
      this.reference,
      this.description,
      this.amount,
      this.sourceName,
      this.sourceId,
      this.currency,
      this.status,
      this.fees,
      this.amountCurrency,
      this.balanceAfter,
      this.paymentType,
      this.type,
      this.createdAt,
      this.updatedAt});

  TransanctionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assCotisationId = json['ass_cotisation_id'];
    assMembreId = json['ass_membre_id'];
    assCompteId = json['ass_compte_id'];
    assInfosVersementId = json['ass_infos_versement_id'];
    mode = json['mode'];
    userGroupId = json['user_group_id'];
    adminId = json['admin_id'];
    adminName = json['admin_name'];
    extraFiltre = json['extra_filtre'];
    reference = json['reference'];
    description = json['description'];
    amount = json['amount'];
    sourceName = json['source_name'];
    sourceId = json['source_id'];
    currency = json['currency'];
    status = json['status'];
    fees = json['fees'];
    amountCurrency = json['amount_currency'];
    balanceAfter = json['balance_after'];
    paymentType = json['payment_type'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
