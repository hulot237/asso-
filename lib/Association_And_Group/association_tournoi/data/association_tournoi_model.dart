
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';


class TournoiModel {

int? id;
String? tournois_code;
String? matricule;
String? reference;
int? diff_days;
String? pourcentage;
int? passed_days;
String? date_debut;
String? date_fin;
bool? is_active;
bool? is_passed;
bool? is_default;
int? user_group_id;
String? created_at;
String? updated_at;




  TournoiModel({

    this.id,
this.tournois_code,
this.matricule,
this.reference,
this.diff_days,
this.pourcentage,
this.passed_days,
this.date_debut,
this.date_fin,
this.is_active,
this.user_group_id,
this.created_at,
this.updated_at,

  });

  factory TournoiModel.fromJson(Map<String, dynamic> json) => TournoiModel(
        id: json["id"],
        tournois_code: json["tournois_code"],
        matricule: json["matricule"],
        reference: json["reference"],
        diff_days: json["diff_days"],
        pourcentage: json["pourcentage"],
        date_debut: json["date_debut"],
        date_fin: json["date_fin"],
        is_active: json["is_active"],
        user_group_id: json['user_group_id'],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );


}
