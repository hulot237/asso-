import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class SeanceRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> DetailSeance(codeSeance) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/seance/$codeSeance/show?membre_code=${AppCubitStorage().state.membreCode}',
    );
    final Map<String, dynamic> dataJson = response.data["data"];
    // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
    log('Okay DetailSeance rep');
    return dataJson;
  }

  Future<List<dynamic>> AllSeanceAss(codeAss) async {
    try {
      log("response DetailSeance");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/seance/$codeAss',
      );
      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailSeance rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailSeance rep');
      return [];
    }
  }

  Future<void> CloseSeance(codeSeance) async {
    final response = await dio.put(
      '${Variables.LienAIP}/api/v1/seance/$codeSeance/close',
    );
  }

  Future<void> genereRapport(codeSeance) async {
    print("$codeSeance");
    print("${AppCubitStorage().state.tokenUser}");
    final response = await dio.post(
      '${Variables.LienAIP}/api/v1/seance/$codeSeance/invoice/send',
      options: Options(
          headers: {
            "token": AppCubitStorage().state.tokenUser,
          },
        ),
    );
  }
}
