// import 'dart:convert';

// DelivererModel delivererModelFromJson(String str) {
//   final jsonData = json.decode(str);
//   return DelivererModel.fromJson(jsonData);
// }

// String delivererModelToJson(DelivererModel data) {
//   final dyn = data.toJson();
//   return json.encode(dyn);
// }

// class DelivererModel {
//   int? id;
//   String? email;
//   String? firstname;
//   String? lastname;
//   String? phone;
//   String? sexe;
//   String? image;
//   String? created_at;
//   String? updated_at;


//   DelivererModel({
//     this.id,
//     this.email,
//     this.firstname,
//     this.lastname,
//     this.phone,
//     this.sexe,
//     this.image,
//     this.created_at,
//     this.updated_at,
//   });

//   factory DelivererModel.fromJson(Map<String, dynamic> json) => DelivererModel(
//         id: json["id"],
//         email: json["email"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         phone: json["phone"],
//         sexe: json["sexe"],
//         image: json["image"],
//         created_at: json["created_at"],
//         updated_at: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "firstname": firstname,
//         "lastname":lastname,
//         "phone":phone,
//         "sexe":sexe,
//         "image":image,
//         "created_at":created_at,
//         "updated_at":updated_at,
//       };
// }
