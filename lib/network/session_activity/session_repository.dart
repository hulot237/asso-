import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';

class SessionRepository {

  final dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);

  Future<Map<String, dynamic>> GetUseSesion() async {
    print("tttttttttttttttttttttttttttt");
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/get-user-session',
      // options: Options(
      //   headers: {
      //     "token": AppCubitStorage().state.tokenUser,
      //   },
      // ),
    );
    print("ssssssssssssssssssssssssssss");
    final Map<String, dynamic> dataJson = response.data["session"];
    log('Okay GetUseSesion rep   ${dataJson}');
    return dataJson;
  }
}
