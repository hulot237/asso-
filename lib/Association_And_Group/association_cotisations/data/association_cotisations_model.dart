import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_versement/data/association_versement_model.dart';

class CotisationModel {
  int? id;
  String? cotisation_code;
  String? matricule;
  String? name;
  String? start_date;
  String? cotisation_pay_link;
  String? end_date;
  int? is_active;
  int? is_passed;
  int? is_tontine;
  String? type;
  int? amount;
  int? is_cotisation_payed;
  String? cotisation_status;
  String? cotisation_balance;
  int? ass_rubrique_cotisation_id;
  int? ass_membre_id;
  int? ass_seance_id;
  int? ass_compte_id;
  int? ass_tournoi_id;
  int? short_link_id;
  MembresModel? membre;
  SeanceModel? seance;
  List<VersemenModel>? versement;
  int? type_event;
  String? created_at;
  String? updated_at;

  CotisationModel({
    this.id,
    this.cotisation_code,
    this.matricule,
    this.name,
    this.start_date,
    this.end_date,
    this.is_active,
    this.is_passed,
    this.is_tontine,
    this.type,
    this.amount,
    this.is_cotisation_payed,
    this.cotisation_status,
    this.cotisation_balance,
    this.membre,
    this.seance,
    this.created_at,
    this.updated_at,
    this.ass_compte_id,
    this.ass_membre_id,
    this.ass_rubrique_cotisation_id,
    this.ass_seance_id,
    this.ass_tournoi_id,
    this.cotisation_pay_link,
    this.short_link_id,
    this.type_event,
    this.versement,
  });

  factory CotisationModel.fromJson(Map<String, dynamic> json) =>
      CotisationModel(
        id: json["id"],
        cotisation_code: json["cotisation_code"],
        matricule: json["matricule"],
        name: json["name"],
        start_date: json["start_date"],
        end_date: json["end_date"],
        is_active: json["is_active"],
        is_passed: json["is_passed"],
        is_tontine: json["is_tontine"],
        type: json["type"],
        amount: json["amount"],
        is_cotisation_payed: json["is_cotisation_payed"],
        cotisation_status: json["cotisation_status"],
        cotisation_balance: json["cotisation_balance"],
        membre: json['membre'] != null
            ? MembresModel.fromJson(json["membre"])
            : null,
        seance: json['seance'] != null
            ? SeanceModel.fromJson(json["seance"])
            : null,
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        ass_compte_id: json["ass_compte_id"],
        ass_membre_id: json["ass_membre_id"],
        ass_rubrique_cotisation_id: json["ass_rubrique_cotisation_id"],
        ass_seance_id: json["ass_seance_id"],
        ass_tournoi_id: json["ass_tournoi_id"],
        cotisation_pay_link: json["cotisation_pay_link"],
        short_link_id: json["short_link_id"],
        type_event: json["type_event"],
        versement: json['versement'] != null ? (json['versement'] as List).map((e) => VersemenModel.fromJson(e)).toList(): null,
      );
}
