import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/collecte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/participant_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';

class CotisationRepository {
  final dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);
  Future<Map<String, dynamic>> DetailCotisation(codeCotisation) async {
    print(codeCotisation);
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/cotisation/$codeCotisation/show',
    );
    final Map<String, dynamic> dataJson = response.data["data"];
    log('Okay DetailCotisation rep   ${dataJson}');
    return dataJson;
  }

  Future<void> PayOneCotisation(
      codeCotisation, amount, membre_code, code_ass, hashid, type_id,
      {String? contribution_code}) async {
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
        "contribustion_code": contribution_code,
      },
    );
  }

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

  Future<CollecteModel> getCollectes(codeTournoi) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/get-all-collecte',
    );
    final Map<String, dynamic> dataJson = response.data["data"];
    log('Okay DetailCotisation rep   ${dataJson}');
    return CollecteModel.fromJson(dataJson);
  }

  Future<List<Participants>> getParticipantCollecte(codeCollecte) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/collecte/$codeCollecte/get-all-participants',
    );

    final List<dynamic> dataJson = response.data["participants"];
    final List<Participants> dataParticipants = dataJson
        .map<Participants>(
            (json) => Participants.fromJson(json))
        .toList();
    log('Okay dataParticipants rep   ${dataParticipants}');
    return dataParticipants;
  }
}
