// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthRepository  {
//   Future<Map<String, dynamic>?> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.43.163:3333/loginDeliverer'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );

//       Map data = jsonDecode(response.body);
      
//       print(data['data']);
//       print("login success reposit");
//       return data['data'];
//     } catch (e) {
//       print("login echec reposit");
//       return null;
//     }
//   }

// }
