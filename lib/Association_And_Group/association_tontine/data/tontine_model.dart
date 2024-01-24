class TontineModel {
  int? id;
  String? tontine_code;
  String? libele;
  String? amount;
  int? is_active;
  int? is_suspended;
  int? user_group_id;
  String? created_at;
  String? updated_at;

  String? matricule;


  // {
  //               "motif": "BREAKING BAD",
  //               "is_auto_sanction": 0,
  //               "motif_sanction": null,
  //               "type_sanction": "0",
  //               "libelle_sanction": null,
  //               "amount_sanction": null,
  //               "date_sanction": null,
  //               "start_date": "2023-11-28T11:00:00.000Z",
  //               "tontine_pay_link": "faro.ink/eedeDI",
  //               "end_date": "2023-11-28T11:00:00.000Z",
  //               "is_active": 0,
  //               "is_passed": 0,
  //               "type": "0",
  //               "amount": 2000,
  //               "is_tontine_payed": 0,
  //               "tontine_balance": "0",
  //               "ass_membre_id": 7,
  //               "ass_seance_id": 1,
  //               "ass_compte_id": 12,
  //               "ass_tournois_id": 3,
  //               "ass_tontine_tournois_id": 1,
  //               "short_link_id": 471,
  //               "created_at": "2023-11-28T15:36:16.000+01:00",
  //               "updated_at": "2023-11-28T15:36:16.000+01:00",
  //               "membre": {
  //                   "id": 7,
  //                   "ass_role_id": 1,
  //                   "user_delete": null,
  //                   "user_create": null,
  //                   "first_name": "KENGNE DJOUSSE",
  //                   "matricule": "DEVE001",
  //                   "membre_code": "M79556",
  //                   "last_name": "Hulot",
  //                   "first_phone": "680474835",
  //                   "second_phone": null,
  //                   "email": "kengnedjoussehulot@gmail.com",
  //                   "residence": null,
  //                   "phonenumber": "",
  //                   "countrycode": 0,
  //                   "country": "23586",
  //                   "region": null,
  //                   "city": null,
  //                   "hasid": "73fade63-de3f-4072-bb97-016df10547fe",
  //                   "inscription_pay_link": "faro.ink/fFaIFG",
  //                   "is_inscription_payed": 0,
  //                   "inscription_status": "0",
  //                   "inscription_balance": "0",
  //                   "entry_amount": "5000",
  //                   "type": "2",
  //                   "marital_status": "0",
  //                   "date_adhesion": "2023-11-24T07:47:00.000Z",
  //                   "photo_profil": null,
  //                   "is_active": 1,
  //                   "notification_token": "f6U5d9rKRtS3A-Xyl638hS:APA91bF6UoCkgyscRayKzALlLjJdRLfbFovOOXc9r6Nhti4KN3ntc3UapIejU7HdjTd9LcAtibtN5DfyN0TLbJsrlqwTCBYWvmABiZSiYH1zVPds0S-_85n5PSxBv5-6FVoTIUvDQcJq",
  //                   "lang": "fr",
  //                   "is_withdrawal_approvers": 0,
  //                   "user_group_id": 5,
  //                   "short_link_id": 448,
  //                   "created_at": "2023-11-24T09:47:02.000+01:00",
  //                   "updated_at": "2024-01-20T12:03:55.000+01:00",
  //                   "isFounder": false,
  //                   "isSuperAdmin": true,
  //                   "isMember": false
  //               },
  //               "versement": [],
  //               "type_event": 2
  //           }



  TontineModel({
    this.id,
    this.libele,
    this.amount,
    this.tontine_code,
    this.is_active,
    this.is_suspended,
    this.user_group_id,
    this.created_at,
    this.updated_at,
  });

  factory TontineModel.fromJson(Map<String, dynamic> json) {
    return TontineModel(
      id: json["id"],
      libele: json["libele"],
      amount: json["amount"],
      tontine_code: json["tontine_code"],
      is_active: json["is_active"],
      is_suspended: json["is_suspended"],
      user_group_id: json["user_group_id"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "libele": libele,
        "amount": amount,
        "tontine_code": tontine_code,
        "is_active": is_active,
        "is_suspended": is_suspended,
        "user_group_id": user_group_id,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
