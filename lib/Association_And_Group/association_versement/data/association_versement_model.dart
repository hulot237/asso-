import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_model.dart';

class VersemenModel {
  int? id;
  String? source_name;
  String? source_id;
  String? source_amount;
  String? amount;
  String? balance_after;
  String? balance_remaining;
  String? currency;
  bool? is_versement_finished;
  int? status;
  String? versement_balance;
  MembresModel? membre;
  String? created_at;
  String? updated_at;

  VersemenModel({
    this.id,
    this.source_name,
    this.source_id,
    this.source_amount,
    this.amount,
    this.balance_after,
    this.balance_remaining,
    this.currency,
    this.is_versement_finished,
    this.status,
    this.versement_balance,
    this.membre,
    this.created_at,
    this.updated_at
  });

  factory VersemenModel.fromJson(Map<String, dynamic> json) => VersemenModel(
        id: json["id"],
        source_name: json["source_name"],
        source_id: json["source_id"],
        source_amount: json["source_amount"],
        amount: json["amount"],
        balance_after: json["balance_after"],
        balance_remaining: json["balance_remaining"],
        currency: json["currency"],
        is_versement_finished: json["is_versement_finished"],
        status: json['status'] ,
        versement_balance: json['versement_balance'],
        membre: json["membre"] != null
            ? MembresModel.fromJson(json["membre"])
            : null,
        created_at: json["created_at"],
      updated_at: json["updated_at"]
      );
}
