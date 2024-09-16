// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppStorageModel {
  String? Language;
  String? codeTournois;
  String? codeTournoisHist;
  String? xSessionId;
  String? codeAssDefaul;
  String? membreCode;
  String? tokenNotification;
  String? passwordKey;
  String? tokenUser;
  String? userNameKey;
  String? dataCookies;
  String? passWordTontinePerso;
  final bool isLoading;
  bool maskSold;
  bool isNoSubmit;
  List<UserAction>? trakingData;


  AppStorageModel({
    this.Language,
    this.codeTournois,
    this.codeTournoisHist,
    this.xSessionId,
    this.codeAssDefaul,
    this.membreCode,
    this.tokenUser,
    this.tokenNotification,
    this.passwordKey,
    this.isLoading = false,
    this.userNameKey,
    this.dataCookies,
    this.trakingData,
    this.passWordTontinePerso,
    this.maskSold = false,
    this.isNoSubmit = true,
  });

  AppStorageModel copyWith({
    String? Language,
    String? codeTournois,
    String? codeTournoisHist,
    String? xSessionId,
    String? codeAssDefaul,
    String? membreCode,
    String? tokenNotification,
    String? passwordKey,
    String? tokenUser,
    String? userNameKey,
    String? dataCookies,
    String? passWordTontinePerso,
    bool? isLoading,
    bool? maskSold,
    bool? isNoSubmit,
    List<UserAction>? trakingData,
  }) {
    return AppStorageModel(
      Language: Language ?? this.Language,
      codeTournois: codeTournois ?? this.codeTournois,
      codeTournoisHist: codeTournoisHist?? this.codeTournoisHist,
      xSessionId: xSessionId ?? this.xSessionId,
      codeAssDefaul: codeAssDefaul ?? this.codeAssDefaul,
      membreCode: membreCode ?? this.membreCode,
      tokenNotification: tokenNotification ?? this.tokenNotification,
      passwordKey: passwordKey ?? this.passwordKey,
      tokenUser: tokenUser ?? this.tokenUser,
      userNameKey: userNameKey ?? this.userNameKey,
      dataCookies: dataCookies ?? this.dataCookies,
      isLoading: isLoading ?? this.isLoading,
      trakingData: trakingData ?? this.trakingData,
      passWordTontinePerso: passWordTontinePerso ?? this.passWordTontinePerso,
      maskSold:  maskSold ?? this.maskSold,
      isNoSubmit: isNoSubmit ?? this.isNoSubmit,
    );
  }
}



class UserAction {
  final String code;
  final String date;
  final Map<String, dynamic> data;

  UserAction({required this.code, required this.date, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'date': date,
      'data': data,
    };
  }
}