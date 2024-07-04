import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class CotisationRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> DetailCotisation(codeCotisation) async {
    print(codeCotisation);
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/cotisation/$codeCotisation/show',
    );
    final Map<String, dynamic> dataJson = response.data["data"];
    log('Okay DetailCotisation rep   ${dataJson}');
    return dataJson;
  }

  Future<void> PayOneCotisation(codeCotisation, amount, membre_code, code_ass, hashid, type_id, {String? contribution_code}) async {
    print("codeCotisation $codeCotisation");
    print("amount $amount");
    print("membre_code $membre_code");
    print("code_ass $code_ass");
    print("hashid $hashid");
    print("tokenUser ${AppCubitStorage().state.tokenUser}");
    print("type_id ${type_id}");
    print("contribution_code ${contribution_code}");
    final response = await dio.post(
      '${Variables.LienAIP}/api/v1/payment',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
      data: {
        "admin_id": hashid,
        "amount": amount,
        "membre_code": membre_code,
        "partner_urlcode": code_ass,
        "source_code": codeCotisation,
        "type_id": type_id,
        "contribustion_code":contribution_code,
      },
    );
  }

  // https://api.groups.faroty.com/api/v1/payment

  Future<List<dynamic>> AllCotisationOfAssTournoi(
      codeTournoi, codeMembre) async {
    try {
      log("response AllCotisationOfAssAllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/membre/$codeMembre/get-cotisation-of-membre',
      );
      final List<dynamic> dataJson = response.data["data"]["cotisations"];
      log('Okay AllCotisationOfAssAllCotisationOfAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllCotisationOfAssAllCotisationOfAss rep');

      return [];
    }
  }
}
