import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class CompteRepository {
  final dio = Dio();
// http://192.168.1.110:3333/api/v1/cotisation/1hcul26gv/show

  Future<List<CompteModel>> AllCompteAss(codeAssociation) async {
    try {
      log("response AllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/compte/$codeAssociation',
      );
      final List<dynamic> dataJson = response.data["data"];
      final List<CompteModel> dataCompteModel = dataJson.map<CompteModel>((json)=> CompteModel.fromJson(json)).toList();

      return dataCompteModel;
    } catch (e) {
      log('erreur AllCotisationOfAss rep');
      return [];
    }
  }
}
