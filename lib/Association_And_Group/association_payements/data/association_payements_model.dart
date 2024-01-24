import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/data/association_saction_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_versement/data/association_versement_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class PayementModel {
  int? id;
  CotisationModel? cotisation;
  MembresModel? membre;
  CompteModel? compte;
  VersemenModel? versement;
  SanctionModel? sanction;
  int? Payment_id;
  UserGroupModel? user_group_id;
  String? admin_id;
  String? reference;
  String? description;
  String? amount;
  String? source_name;
  String? source_id;
  String? currency;
  String? status;
  String? fees;
  String? amount_currency;
  String? balance_after;
  String? payment_type;
  String? created_at;
  String? updated_at;

  PayementModel({
    this.id,
    this.cotisation,
    this.membre,
    this.compte,
    this.versement,
    this.sanction,
    this.Payment_id,
    this.user_group_id,
    this.admin_id,
    this.reference,
    this.description,
    this.amount,
    this.source_name,
    this.source_id,
    this.currency,
    this.status,
    this.fees,
    this.amount_currency,
    this.balance_after,
    this.payment_type,
    this.created_at,
    this.updated_at,
  });

  factory PayementModel.fromJson(Map<String, dynamic> json) => PayementModel(
        id: json["id"],
        cotisation: json['cotisation'] != null
            ? CotisationModel.fromJson(json["cotisation"])
            : null,
        membre: json['membre'] != null
            ? MembresModel.fromJson(json["membre"])
            : null,
        compte: json['compte'] != null
            ? CompteModel.fromJson(json["compte"])
            : null,
        versement: json['versement'] != null
            ? VersemenModel.fromJson(json["versement"])
            : null,
        sanction: json['sanction'] != null
            ? SanctionModel.fromJson(json["sanction"])
            : null,
        Payment_id: json["Payment_id"],
        user_group_id: json["user_group_id"],
        admin_id: json["admin_id"],
        reference: json["reference"],
        description: json["description"],
        amount: json["amount"],
        source_name: json["source_name"],
        source_id: json["source_id"],
        currency: json["currency"],
        status: json["status"],
        fees: json["fees"],
        amount_currency: json["amount_currency"],
        balance_after: json["created_at"],
        payment_type: json["updated_at"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
