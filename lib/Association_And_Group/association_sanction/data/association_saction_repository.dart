import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class SanctionRepository {
  final dio = Dio();
  Future<List<dynamic>> getAllSanctions(codeTournoi) async {
    print("rrrrrrrrrrrrrrr");
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/sanction/$codeTournoi',
    );
    var data = response.data['data']['sanctions'];

    print("rrrrrrrrrrrrrrr rrrrrrrrrrrr $data");
    return data;
  }
}
