class UserModel {
  int? id;
  int? ass_role_id;
  String? first_name;
  String? matricule;
  String? membre_code;
  String? last_name;
  String? first_phone;
  String? second_phone;
  String? email;
  String? residence;
  String? phonenumber;
  int? countrycode;
  String? country;
  String? region;
  String? city;
  String? inscription_pay_link;
  int? is_inscription_payed;
  String? inscription_status;
  String? inscription_balance;
  String? entry_amount;
  String? type;
  String? marital_status;
  String? date_adhesion;
  String? photo_profil;
  int? is_active;
  String? notification_token;
  String? lang;
  int? is_withdrawal_approvers;
  int? user_group_id;
  String? created_at;
  String? updated_at;
  bool? isFounder;
  bool? isSuperAdmin;
  bool? isMember;

  UserModel({
    this.id,
    this.ass_role_id,
    this.first_name,
    this.matricule,
    this.membre_code,
    this.last_name,
    this.first_phone,
    this.second_phone,
    this.email,
    this.residence,
    this.phonenumber,
    this.countrycode,
    this.country,
    this.region,
    this.city,
    this.inscription_pay_link,
    this.is_inscription_payed,
    this.inscription_status,
    this.inscription_balance,
    this.entry_amount,
    this.type,
    this.marital_status,
    this.date_adhesion,
    this.photo_profil,
    this.is_active,
    this.notification_token,
    this.lang,
    this.is_withdrawal_approvers,
    this.user_group_id,
    this.created_at,
    this.updated_at,
    this.isFounder,
    this.isSuperAdmin,
    this.isMember,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      ass_role_id: json["ass_role_id"],
      first_name: json["first_name"],
      matricule: json["matricule"],
      membre_code: json["membre_code"],
      last_name: json["last_name"],
      first_phone: json["first_phone"],
      second_phone: json["second_phone"],
      email: json["email"],
      residence: json["residence"],
      phonenumber: json["phonenumber"],
      countrycode: json["countrycode"],
      country: json["country"],
      region: json["region"],
      city: json["city"],
      inscription_pay_link: json["inscription_pay_link"],
      is_inscription_payed: json["is_inscription_payed"],
      inscription_status: json["inscription_status"],
      inscription_balance: json["inscription_balance"],
      entry_amount: json["entry_amount"],
      type: json["type"],
      marital_status: json["marital_status"],
      date_adhesion: json["date_adhesion"],
      photo_profil: json["photo_profil"],
      is_active: json["is_active"],
      notification_token:
          json["notification_token"] == null ? "" : json["notification_token"],
      lang: json["lang"],
      is_withdrawal_approvers: json["is_withdrawal_approvers"],
      user_group_id: json["user_group_id"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      isFounder: json["isFounder"],
      isSuperAdmin: json["isSuperAdmin"],
      isMember: json["isMember"],
    );
  }
}
