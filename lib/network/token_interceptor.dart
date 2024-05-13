import 'dart:io';

import 'package:dio/dio.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class TokenInterceptor extends QueuedInterceptor {
  // Dio dio = Dio(BaseOptions(baseUrl: "base-api-url"));

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var X_SESSION_ID = await AppCubitStorage().state.xSessionId;
    var X_APP_MODE = await Platform.isIOS ? "ios" : "android";
    var X_ASS_URLCODE = await AppCubitStorage().state.codeAssDefaul;
    var token = await AppCubitStorage().state.tokenUser;

    options.headers.addAll({

      "X-SESSION-ID": X_SESSION_ID,
      "X-APP-MODE": X_APP_MODE,
      "X-ASS-URLCODE": X_ASS_URLCODE,
      "token": token,
    });
    // get token from the storage
    // if (token != null) {
    //   options.headers.addAll({
    //     "Authorization": "Bearer ${token}",
    //   });
    // }
    return super.onRequest(options, handler);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

}
