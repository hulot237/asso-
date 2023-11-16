import 'package:faroty_association_1/Association_And_Group/association_tontine/data/association_tontine_model.dart';

import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_model.dart';

class UserGroupModel {
  int? id;
  int? partner_id;
  String? urlcode;
  String? user_group_code;
  String? matricule;
  int? user_id;
  int? user_delete;
  String? hash_id;
  String? name;
  String? description;
  int? sms_balance;
  String? profile_photo;
  String? create_date;
  String? delete_date;
  String? last_update_time;
  int? status;
  String? entry_amount;
  String? min_help_amount;
  bool? is_tontine;
  bool? is_default;
  TontineModel? tontine;

  UserGroupModel({
    this.id,
    this.partner_id,
    this.urlcode,
    this.user_group_code,
    this.matricule,
    this.user_id,
    this.user_delete,
    this.hash_id,
    this.name,
    this.description,
    this.sms_balance,
    this.profile_photo,
    this.create_date,
    this.delete_date,
    this.last_update_time,
    this.status,
    this.entry_amount,
    this.min_help_amount,
    this.is_tontine,
    this.is_default,
    this.tontine,
  });

  factory UserGroupModel.fromJson(Map<String, dynamic> json) {
    try {
      final temp = UserGroupModel(
        id: json["id"],
        partner_id: json["partner_id"],
        urlcode: json["urlcode"],
        user_group_code: json["user_group_code"],
        matricule: json["matricule"],
        user_id: json["user_id"],
        user_delete: json["user_delete"],
        hash_id: json["hash_id"],
        name: json["name"],
        description: json['description'],
        sms_balance: json["sms_balance"],
        profile_photo: json["profile_photo"],
        create_date: json["create_date"],
        delete_date: json["delete_date"],
        last_update_time: json['last_update_time'],
        status: json["status"],
        entry_amount: json["entry_amount"],
        min_help_amount: json["min_help_amount"],
        is_tontine: json["is_tontine"],
        is_default: json['is_default'],
        tontine: json['tontine'] != null
            ? TontineModel.fromJson(json["tontine"])
            : null,
      );
      print("UserGroupModdddel()");
      return temp;
    } catch (e) {
      return UserGroupModel();
    }
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partner_id,
        "urlcode": urlcode,
        "user_group_code": user_group_code,
        "matricule": matricule,
        "user_id": user_id,
        "user_delete": user_delete,
        "hash_id": hash_id,
        "name": name,
        "description": description,
        "sms_balance": sms_balance,
        "profile_photo": profile_photo,
        "create_date": create_date,
        "delete_date": delete_date,
        "last_update_time": last_update_time,
        "status": status,
        "entry_amount": entry_amount,
        "min_help_amount": min_help_amount,
        "is_tontine": is_tontine,
        "is_default": is_default,
        "tontine": tontine,
      };
}

class UserGroupCourantModel {
  int? id;
  int? partner_id;
  String? urlcode;
  String? user_group_code;
  String? matricule;
  int? user_id;
  int? user_delete;
  String? hash_id;
  String? name;
  String? description;
  int? sms_balance;
  String? profile_photo;
  String? create_date;
  String? delete_date;
  String? last_update_time;
  int? status;
  String? entry_amount;
  String? min_help_amount;
  bool? is_tontine;
  bool? is_default;
  TournoiModel? tournois;
  TontineModel? tontines;

  UserGroupCourantModel({
    this.id,
    this.partner_id,
    this.urlcode,
    this.user_group_code,
    this.matricule,
    this.user_id,
    this.user_delete,
    this.hash_id,
    this.name,
    this.description,
    this.sms_balance,
    this.profile_photo,
    this.create_date,
    this.delete_date,
    this.last_update_time,
    this.status,
    this.entry_amount,
    this.min_help_amount,
    this.is_tontine,
    this.is_default,
    this.tournois,
    this.tontines,
  });

  factory UserGroupCourantModel.fromJson(Map<String, dynamic> json) {
      print("UserGroupCourantModel2");

    try {
      print("UserGroupCourantModel1");

      final temp = UserGroupCourantModel(
        id: json["id"],
        partner_id: json["partner_id"],
        urlcode: json["urlcode"],
        user_group_code: json["user_group_code"],
        matricule: json["matricule"],
        user_id: json["user_id"],
        user_delete: json["user_delete"],
        hash_id: json["hash_id"],
        name: json["name"],
        description: json['description'],
        sms_balance: json["sms_balance"],
        profile_photo: json["profile_photo"],
        create_date: json["create_date"],
        delete_date: json["delete_date"],
        last_update_time: json['last_update_time'],
        status: json["status"],
        entry_amount: json["entry_amount"],
        min_help_amount: json["min_help_amount"],
        is_tontine: json["is_tontine"],
        is_default: json['is_default'],
        tournois: json["tournois"] != null
            ? TournoiModel.fromJson(json["tournois"])
            : null,
        tontines: json['tontines'] != null
            ? TontineModel.fromJson(json["tontines"])
            : null,
      );
      return temp;
    } catch (e) {
      return UserGroupCourantModel();
    }
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partner_id,
        "urlcode": urlcode,
        "user_group_code": user_group_code,
        "matricule": matricule,
        "user_id": user_id,
        "user_delete": user_delete,
        "hash_id": hash_id,
        "name": name,
        "description": description,
        "sms_balance": sms_balance,
        "profile_photo": profile_photo,
        "create_date": create_date,
        "delete_date": delete_date,
        "last_update_time": last_update_time,
        "status": status,
        "entry_amount": entry_amount,
        "min_help_amount": min_help_amount,
        "is_tontine": is_tontine,
        "is_default": is_default,
        "tournois":tournois,
        "tontines": tontines,
      };
}
