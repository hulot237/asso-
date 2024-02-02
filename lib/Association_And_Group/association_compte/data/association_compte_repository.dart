import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

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
      final List<CompteModel> dataCompteModel = dataJson
          .map<CompteModel>((json) => CompteModel.fromJson(json))
          .toList();

      return dataCompteModel;
    } catch (e) {
      log('erreur AllCotisationOfAss rep');
      return [];
    }
  }

  Future<List<dynamic>> getTransactionCompte(codeCompte) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/payment/${AppCubitStorage().state.codeAssDefaul}/all?page=1&per_page=10&source_name=compte&source_ref=$codeCompte&mode=all',
      options: Options(
          headers: {
            "token": AppCubitStorage().state.tokenUser,
          },
        ),
      
    );
    print(AppCubitStorage().state.tokenUser);
    var data = response.data;
    // print("https://api.groups.faroty.com/api/v1/payment/1hjl47g81/all?p ${response.data['data']['payments']}");

    return data['data']['payments'];
  }
}
