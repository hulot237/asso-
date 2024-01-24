import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';

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
  String? background_cover;
  String? create_date;
  String? delete_date;
  String? last_update_time;
  int? status;
  int? is_confirmed;
  int? is_active;
  String? confirmed_date;
  String? entry_amount;
  String? min_help_amount;
  bool? is_tontine;
  bool? is_default;
  List<dynamic>? configs;
  List<TontineModel>? tontines;
  List<TournoiModel>? tournois;

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
    this.background_cover,
    this.configs,
    this.confirmed_date,
    this.is_active,
    this.is_confirmed,
    this.tontines,
    this.tournois,
  });

  factory UserGroupModel.fromJson(Map<String, dynamic> json) => UserGroupModel(
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
        background_cover: json["background_cover"],
        configs: json["configs"],
        confirmed_date: json["confirmed_date"],
        is_active: json["is_active"],
        is_confirmed: json["is_confirmed"],
        tontines: json['tontines'] != null ? (json['tontines'] as List).map((e) => TontineModel.fromJson(e)).toList(): null,
        tournois: json['tournois'] != null ? (json['tournois'] as List).map((e) => TournoiModel.fromJson(e)).toList(): null,
      );
}


class InfoAssModel {
  MembresModel? membre;
  UserGroupModel? user_group;

  InfoAssModel({
    this.membre,
    this.user_group,
  });

  factory InfoAssModel.fromJson(Map<String, dynamic> json) => InfoAssModel(
        membre: json['membre'] != null
            ? MembresModel.fromJson(json["membre"])
            : null,
        user_group: json['user_group'] != null
            ? UserGroupModel.fromJson(json["user_group"])
            : null,
      );
}

