
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';


class CompteModel {

int? id;
UserGroupModel? user_group;
String? type_id;
String? public_ref;
String? matricule;
String? hidden_ref;
String? name;
String? card_name;
String? description;
String? balance;
String? currency;
String? foroti_balance;
String? is_default;
int? status;
String? created_at;
String? updated_at;




  CompteModel({

    this.id,
this.user_group,
this.type_id,
this.public_ref,
this.matricule,
this.hidden_ref,
this.name,
this.card_name,
this.description,
this.balance,
this.currency,
this.foroti_balance,
this.is_default,
this.status,
this.created_at,
this.updated_at,
  });

  factory CompteModel.fromJson(Map<String, dynamic> json) => CompteModel(
        id: json["id"],
        user_group: json['user_group'] != null ? UserGroupModel.fromJson(json["user_group"]): null,
        type_id: json["type_id"],
        public_ref: json["public_ref"],
        matricule: json["matricule"],
        hidden_ref: json["hidden_ref"],
        name: json["name"],
        card_name: json["card_name"],
        description: json["description"],
        balance: json["balance"],
        currency: json["currency"],
        foroti_balance: json["foroti_balance"],
        is_default: json["is_default"],
        status: json["status"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );


}
