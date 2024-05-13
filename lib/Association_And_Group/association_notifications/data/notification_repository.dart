import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class NotificationRepository {
  final dio = Dio();
  Future<List<NotificationModel>> getNotification(
      tokenUser, codeAssociation, page, limit) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/membre/$codeAssociation/notifications/get?page=$page&per_page=$limit',
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
    return data
        .map<NotificationModel>((json) => NotificationModel.fromJson(json))
        .toList();
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

  Future<int> countNotification() async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/membre/${AppCubitStorage().state.codeAssDefaul}/notifications/count?versionApp${Variables.version}',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
    );
    var numberNotif = response.data["data"];
    return numberNotif;
  }
}