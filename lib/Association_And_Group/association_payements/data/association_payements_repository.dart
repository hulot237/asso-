import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class PayementRepository {
  final dio = Dio();
  Future<bool> ApprouvePayement(withdrawId, codeMembre) async {
    try {
      log("response ApprouvePayement");
      final response = await dio.patch(
        '${Variables.LienAIP}/api/v1/payment/$withdrawId/membre/$codeMembre/approve',
      );
      final bool dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay ApprouvePayement rep');
      return dataJson;
    } catch (e) {
      log('erreur ApprouvePayement rep');
      return false;
    }
  }
}