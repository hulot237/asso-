import 'package:faroty_association_1/localStorage/localCubit.dart';

class Variables {
  static String LienAIP = 'https://api.groups.faroty.com';
  // static String LienAIP = 'https://api.group.rush.faroty.com';

  List urlcodes=[
    "${AppCubitStorage().state.codeAssDefaul}"
  ];

  String codeMembre = "${AppCubitStorage().state.membreCode}";

  static String version = "2.1.0";

  late String? tokenNotification; 
}
