import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_model.dart';

class CotisationModel {
  int? id;
  String? cotisation_code;
  String? matricule;
  String? name;
  bool? is_auto_sanction;
  String? motif_sanction;
  int? type_sanction;
  String? libelle_sanction;
  String? amount_sanction;
  String? date_sanction;
  String? start_date;
  String? end_date;
  bool? is_active;
  bool? is_passed;
  bool? is_tontine;
  int? type;
  int? amount;
  bool? is_cotisation_payed;
  int? cotisation_status;
  String? cotisation_balance;
  MembresModel? membre;
  SeanceModel? seance;
  CompteModel? compte;
  String? created_at;
  String? updated_at;

  CotisationModel({
    this.id,
    this.cotisation_code,
    this.matricule,
    this.name,
    this.is_auto_sanction,
    this.motif_sanction,
    this.type_sanction,
    this.libelle_sanction,
    this.amount_sanction,
    this.date_sanction,
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
    this.compte,
    this.created_at,
    this.updated_at,
  });

  factory CotisationModel.fromJson(Map<String, dynamic> json) =>
      CotisationModel(
        id: json["id"],
        cotisation_code: json["cotisation_code"],
        matricule: json["matricule"],
        name: json["name"],
        is_auto_sanction: json["is_auto_sanction"],
        motif_sanction: json["motif_sanction"],
        type_sanction: json["type_sanction"],
        libelle_sanction: json["libelle_sanction"],
        amount_sanction: json["amount_sanction"],
        date_sanction: json["date_sanction"],
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
        compte: json['compte'] != null
            ? CompteModel.fromJson(json["compte"])
            : null,
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
