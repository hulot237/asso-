import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class MembresModel {
  int? id;
  int? association_role_id;
  String? first_name;
  String? matricule;
  String? membre_code;
  String? last_name;
  String? first_phone;
  String? second_phone;
  String? email;
  String? residence;
  String? country;
  String? region;
  String? city;
  String? hasid;
  bool? is_inscription_payed;
  int? inscription_status;
  String? inscription_balance;
  int? type;
  int? marital_status;
  String? date_adhesion;
  String? photo_profil;
  bool? is_active;
  UserGroupModel? user_group;
  String? created_at;
  String? updated_at;

  MembresModel({
    this.id,
    this.association_role_id,
    this.first_name,
    this.matricule,
    this.membre_code,
    this.last_name,
    this.first_phone,
    this.second_phone,
    this.email,
    this.residence,
    this.country,
    this.region,
    this.city,
    this.hasid,
    this.is_inscription_payed,
    this.inscription_status,
    this.inscription_balance,
    this.type,
    this.marital_status,
    this.date_adhesion,
    this.photo_profil,
    this.is_active,
    this.user_group,
    this.created_at,
    this.updated_at,
  });

  factory MembresModel.fromJson(Map<String, dynamic> json) =>
      MembresModel(
        id: json["id"],
        association_role_id: json["type_id"],
        first_name: json["public_ref"],
        matricule: json["matricule"],
        membre_code: json["hidden_ref"],
        last_name: json["name"],
        first_phone: json["card_name"],
        second_phone: json["description"],
        email: json["balance"],
        residence: json["currency"],
        country: json["foroti_balance"],
        region: json["is_default"],
        city: json["status"],
        hasid: json["hasid"],
        is_inscription_payed: json["is_inscription_payed"],
        inscription_status: json["inscription_status"],
        inscription_balance: json["inscription_balance"],
        type: json["type"],
        marital_status: json["marital_status"],
        date_adhesion: json["date_adhesion"],
        photo_profil: json["photo_profil"],
        is_active: json["is_active"],
        user_group: json['user_group'] != null
            ? UserGroupModel.fromJson(json["user_group"])
            : null,
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
