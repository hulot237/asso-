import 'package:faroty_association_1/localStorage/localCubit.dart';

class Variables {
  static String LienAIP = 'https://api.groups.faroty.com';

  List urlcodes=[
    "${AppCubitStorage().state.codeAssDefaul}"
  ];

  String codeMembre = "${AppCubitStorage().state.membreCode}";

  late String? tokenNotification; 
}
