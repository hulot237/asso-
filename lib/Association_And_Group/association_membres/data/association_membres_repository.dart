import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/user_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class MembersRepository {
  final dio = Dio();

  Future<List<UserModel>> showMembersAss(codeAssociation) async {
    try {
      log("response showMembersAssRepository");
      final response =
          await dio.get('${Variables.LienAIP}/api/v1/membre/$codeAssociation/all');

      // final List<dynamic> dataJson = response.data["data"];
      // final List<CompteModel> dataCompteModel = dataJson.map<CompteModel>((json)=> CompteModel.fromJson(json)).toList();


      final List<dynamic> dataJson = response.data["membres"];
      final List<UserModel> dataUserModel = dataJson.map<UserModel>((json)=> UserModel.fromJson(json)).toList();

      log('Okay showMembersAssRepository rep');
      print("Okay Okay Okay Okay Okay Okay Okay Okay Okay ${dataUserModel}");
      return dataUserModel;
    } catch (e) {
      log('erreur showMembersAssRepository rep');
      return [];
    }
  }
}
