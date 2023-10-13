import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_model.dart';

class SanctionModel {
  int? id;
  String? sanction_code;
  String? matricule;
  String? motif;
  String? start_date;
  int? amount;
  bool? is_suspended;
  bool? status;
  bool? is_passed;
  bool? is_sanction_payed;
  String? libelle;
  int? type;
  int? sanction_status;
  String? sanction_balance;
  MembresModel? membre;
  SeanceModel? seance;
  CompteModel? compte;
  String? created_at;
  String? updated_at;

  SanctionModel({
    this.id,
    this.sanction_code,
    this.matricule,
    this.motif,
    this.start_date,
    this.amount,
    this.is_suspended,
    this.status,
    this.is_passed,
    this.is_sanction_payed,
    this.libelle,
    this.type,
    this.sanction_status,
    this.sanction_balance,
    this.membre,
    this.seance,
    this.compte,
    this.created_at,
    this.updated_at,
  });

  factory SanctionModel.fromJson(Map<String, dynamic> json) =>
      SanctionModel(
        id: json["id"],
        sanction_code: json["sanction_code"],
        matricule: json["matricule"],
        motif: json["motif"],
        start_date: json["start_date"],
        amount: json["amount"],
        is_suspended: json["is_suspended"],
        status: json["status"],
        is_passed: json["is_passed"],
        is_sanction_payed: json["is_sanction_payed"],
        libelle: json["libelle"],
        type: json["type"],
        sanction_status: json["sanction_status"],
        sanction_balance: json["sanction_balance"],
        
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
