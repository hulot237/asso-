import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class NotificationRepository {
  final dio = Dio();
  Future<List<NotificationModel>> getNotification(tokenUser, codeAssociation) async {
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$codeAssociation/notifications/get',
        options: Options(
          headers: {
            "token": tokenUser,
          },
        ),
      );
      var data = response.data['data']['notifications'];
      print('dcdcd');
      print("ßssssssssssssssssssssssssssssssssssssss ${data}");
      // return NotificationModel.fromJson(data['data']['notifications']);
      return data.map<NotificationModel>((json)=> NotificationModel.fromJson(json)).toList();
  }

  Future<void> updateNotification(idNotification) async {
    print("object $idNotification");
      await dio.patch(
        '${Variables.LienAIP}/api/v1/notification/$idNotification/read',
      );
      // var data = response.data['data']['notifications'];
      // print('dcdcd');
      // print("ßssssssssssssssssssssssssssssssssssssss ${data}");
      // // return NotificationModel.fromJson(data['data']['notifications']);
  }
}
// https://api.group.rush.faroty.com/api/v1/notification/60/read
  // Future<List<CompteModel>> AllCompteAss(codeAssociation) async {
  //   try {
  //     log("response AllCotisationOfAss");
  //     final response = await dio.get(
  //       '${Variables.LienAIP}/api/v1/compte/$codeAssociation',
  //     );
  //     final List<dynamic> dataJson = response.data["data"];
  //     final List<CompteModel> dataCompteModel = dataJson.map<CompteModel>((json)=> CompteModel.fromJson(json)).toList();

  //     return dataCompteModel;
  //   } catch (e) {
  //     log('erreur AllCotisationOfAss rep');
  //     return [];
  //   }
  // }

  // Future<AuthModel> ConfirmationRepository(codeConfirmation) async {
  //   final response = await dio.post(
  //       '${Variables.LienAIP}/confirmation?notification_token=${AppCubitStorage().state.tokenNotification}',
  //       data: {
  //         "code": codeConfirmation,
  //       },
  //     );

  //     var data = response.data;
    
  //     return AuthModel.fromJson(data['data']);
  // }