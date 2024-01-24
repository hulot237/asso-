// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/user_model.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';

class AuthModel {
  UserModel? user;
  String? username;
  String? password;
  String? token;
  TournoiModel? tournoi;
  List<UserGroupModel>? userGroup;

  AuthModel({
    this.user,
    this.username,
    this.password,
    this.token,
    this.tournoi,
    this.userGroup,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      user: UserModel.fromJson(json["membre"]),
      username: json["username"],
      password: json["password"],
      token: json["token"],
      tournoi: json['tournois'] != null ? TournoiModel.fromJson(json["tournois"]) : null,
      userGroup: json['user_groups'] != null ? (json['user_groups'] as List).map((e) => UserGroupModel.fromJson(e)).toList(): null,
    );

}
