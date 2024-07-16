import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_model.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> UserDetail(userCode, codeTournoi) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/membre/$userCode/show?tournois_code=$codeTournoi&version_app=${Variables.version}&app_mode=${Platform.isAndroid ? "android" : "ios"}',
    );
    final Map<String, dynamic> dataJson = response.data["data"];

    return dataJson;
  }

  Future<String> getUid() async {
    try {
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/getuid',
        options: Options(
          headers: {
            "token": AppCubitStorage().state.tokenUser,
          },
        ),
      );
      final dataJson = json.encode(response.data);

      return dataJson;
    } catch (e) {
      log('erreur getUid rep');
      print(e);
      return "";
    }
  }

  Future<bool> LoginRepository(numeroPhone, countrycode) async {
    try {
      log("response LoginRepository");
      final response = await dio.post(
        '${Variables.LienAIP}/login',
        data: {
          "phone": numeroPhone,
          "countrycode": countrycode,
        },
      );

      final bool dataJson = response.data["error"];
      log('Okay LoginRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur LoginRepository rep');
      print(e);
      return true;
    }
  }

  Future<void> LoginWebViewRepository(
    numeroPhone,
    nameUser,
    countrycode,
    context,
    isForCreate,
    isFisrt,
  ) async {
    print("LoginWebViewRepositoryhhh");
    late String apiToken;
    late String apiPassword;

    Map<String, dynamic> requestBody1 = {
      "iso3": "cm",
      "utc": 1,
      "lang": "fr",
      "token": "",
      "app_name": "android"
    };

    String url1 = 'https://auth.core.faroty.com/api/v1/inituser';

    try {
      Response response1 = await dio.post(
        url1,
        data: requestBody1,
      );

      if (response1.statusCode == 200) {
        apiToken = response1.data['api_token'];
        apiPassword = response1.data['api_password'];
        await AppCubitStorage().updateuserNameKey(apiToken);
        await AppCubitStorage().updatepasswordKey(apiPassword);

        print("userNameKey ${AppCubitStorage().state.userNameKey}");
        print("passwordKey ${AppCubitStorage().state.passwordKey}");
        print("apiTokene $nameUser");
        print("apiPassword $numeroPhone");
        print("apiPassword $countrycode");

        Map<String, dynamic> requestBody2 = {
          "name": "$nameUser",
          "phone": "$numeroPhone",
          "dob": "2002-05-09",
          "email": "",
          "image_string": "",
          "ind": "$countrycode",
          "auth_type": "phone"
        };

        ////////////////////////////////////////////////////////////////////////
        String url2 = 'https://auth.core.faroty.com/api/v1/setprofile';
        print("userNameKey1 ${AppCubitStorage().state.userNameKey}");

        Response response2 = await dio.post(
          url2,
          data: requestBody2,
          options: Options(
            headers: {
              'username': apiToken,
              'password': apiPassword,
            },
          ),
        );
        print("userNameKey2 ${AppCubitStorage().state.userNameKey}");

        if (response2.statusCode == 200 && response2.data["error"] == false) {
          print("userNameKey3 ${AppCubitStorage().state.userNameKey}");
          isFisrt
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationPage(
                      isForCreate: isForCreate,
                      numeroPhone: numeroPhone,
                      countryCode: countrycode,
                      nameUser: nameUser,
                    ),
                  ),
                )
              : Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => VerificationPage(
                      isForCreate: isForCreate,
                      numeroPhone: numeroPhone,
                      countryCode: countrycode,
                      nameUser: nameUser,
                    ),
                  ),
                );
        } else {
          print(
              'Erreur lors de la requête setprofile : ${response2.statusCode}');
        }
      } else {
        print('Erreur lors de la requête inituser : ${response1.statusCode}');
      }
    } catch (e) {
      print('Erreur de connexion : $e');
    }
  }

  Future<String> ConfirmationForCreateRepository(String confirmCode) async {
    var dio = Dio();

    var url = 'https://auth.core.faroty.com/api/v1/confirmuser';

    print("userNameKey ${AppCubitStorage().state.userNameKey}");
    print("passwordKey ${AppCubitStorage().state.passwordKey}");

    // var data = {
    //   "confirmCode": confirmCode,
    // };

    // var headers = {
    //   'username': AppCubitStorage().state.userNameKey,
    //   'password': AppCubitStorage().state.passwordKey,
    // };

    try {
      var response = await dio.post(
        url,
        data: {
          "confirmCode": confirmCode,
        },
        options: Options(
          headers: {
            'username': AppCubitStorage().state.userNameKey,
            'password': AppCubitStorage().state.passwordKey,
          },
        ),
      );

      await AppCubitStorage()
          .updateuserNameKey(response.data['user']['api_token']);
      await AppCubitStorage().updatepasswordKey(response.data['api_password']);
      print('Request successful: ${response.data}');
      return json.encode(response.data);
    } catch (e) {
      print('Exception encountered: $e');
      return "";
    }
  }

  Future<AuthModel> ConfirmationRepository(codeConfirmation) async {
    final response = await dio.post(
      '${Variables.LienAIP}/confirmation?notification_token=${AppCubitStorage().state.tokenNotification}',
      data: {
        "code": codeConfirmation,
      },
    );

    var data = response.data;

    return AuthModel.fromJson(data['data']);
  }

  Future<AuthModel> loginInfoConnectToWebViewFirstRepository(
    apiToken,
    apiPassword,
  ) async {
    print(
        ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${apiToken};;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${apiPassword};;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/get-auth-user?notification_token=${AppCubitStorage().state.tokenNotification}',
      options: Options(
        headers: {
          "username": apiToken,
          "password": apiPassword,
        },
      ),
    );
    print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    var data = response.data;
    print("############################### $data");

    return AuthModel.fromJson(data['data']);
  }

  Future<Map<String, dynamic>> UpdateInfoUserRepository(
      key, value, partner_urlcode, membre_code) async {
    print("key $key");
    log(
      "$value ..",
    );
    print("partner_urlcode $partner_urlcode");
    print("membre_code $membre_code");
    try {
      final response =
          await dio.put('${Variables.LienAIP}/api/v1/membre/update', data: {
        "key": key,
        "value": value,
        "photo_profil_mobile": value,
        "partner_urlcode": partner_urlcode,
        "membre_code": membre_code,
      });
      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UpdateInfoUser rep');
      return dataJson;
    } catch (e) {
      log('erreur UpdateInfoUser rep');
      print(e);
      return {};
    }
  }
}
