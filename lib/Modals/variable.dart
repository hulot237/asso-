import 'package:faroty_association_1/localStorage/localCubit.dart';

class Variables {
  static String LienAIP = 'http://192.168.1.110:3333';

  List urlcodes=[
    "567505","336050"
  ];

  static String codeMembre = "${AppCubitStorage().state.membreCode}";
}
