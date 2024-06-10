import 'package:faroty_association_1/localStorage/localCubit.dart';

class Variables {
  static String LienAIP = 'https://api.groups.faroty.com';
  static String LienInvit = 'https://groups.faroty.com';

  // static String LienAIP = 'https://api.group.rush.faroty.com';
  // static String LienInvit = 'https://group.rush.faroty.com';


  List urlcodes=[
    "${AppCubitStorage().state.codeAssDefaul}"
  ];

  String codeMembre = "${AppCubitStorage().state.membreCode}";

  // static String version = "1.11.10";
  static String version = "1.10.9";
   

  late String? tokenNotification; 
}
