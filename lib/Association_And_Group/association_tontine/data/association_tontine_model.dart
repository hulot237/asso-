class TontineModel {
  int? id;
  String? libele;
  String? amount;
  String? tontine_code;
  String? is_active;
  int? is_suspended;
  bool? user_group_id;
  bool? created_at;
  bool? updated_at;

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
    print("TontineModel()");
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
