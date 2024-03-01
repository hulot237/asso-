import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class PretEpargneRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> getEpargne() async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/tournois/${AppCubitStorage().state.codeTournois}/membre/${AppCubitStorage().state.membreCode}/get-details-saving',
    );
    var data = response.data['data'];
    return data;
  }

  Future<Map<String, dynamic>> getPret() async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/tournois/${AppCubitStorage().state.codeTournois}/membre/${AppCubitStorage().state.membreCode}/get-details-loan',
    );
    var data = response.data['data'];
    return data;
  }

  Future<List<dynamic>> getDetailEpargne(codeEpargne) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/payment/${AppCubitStorage().state.codeAssDefaul}/all?page=1&per_page=50&source_name=savings&source_ref=$codeEpargne',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
    );
    var data = response.data['payement'];

    return data;
  }

  Future<List<dynamic>> getDetailPret(codePret) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/payment/${AppCubitStorage().state.codeAssDefaul}/all?page=1&per_page=50&source_name=loans&source_ref=$codePret',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
    );
    var data = response.data['payement'];
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${data}");

    return data;
  }
}
  // }