import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';

class SeanceModel {
  int? id;
  String? seance_code;
  String? matricule;
  String? date_seance;
  String? localisation;
  String? heure_debut;
  int? is_attendance_list;
  int? is_active;
  int? status;
  String? type_rencontre;
  String? ass_tournois_id;
  String? ass_membre_id;
  String? created_at;
  String? updated_at;

  SeanceModel({
    this.id,
    this.seance_code,
    this.matricule,
    this.date_seance,
    this.localisation,
    this.heure_debut,
    this.is_attendance_list,
    this.is_active,
    this.status,
    this.created_at,
    this.updated_at,
    this.ass_membre_id,
    this.ass_tournois_id,
    this.type_rencontre,
  });

  factory SeanceModel.fromJson(Map<String, dynamic> json) => SeanceModel(
        id: json["id"],
        seance_code: json["seance_code"],
        matricule: json["matricule"],
        date_seance: json["date_seance"],
        localisation: json["localisation"],
        heure_debut: json["heure_debut"],
        is_attendance_list: json["is_attendance_list"],
        is_active: json["is_active"],
        status: json["status"],
        ass_membre_id: json["ass_membre_id"],
        ass_tournois_id: json["ass_tournois_id"],
        type_rencontre: json["type_rencontre"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
