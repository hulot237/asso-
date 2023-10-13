// import 'package:equatable/equatable.dart';
// import 'package:integration_part_two/authentication/data/deliverer_model.dart';

// class AuthState extends Equatable {
//   final bool isAuthenticated;
//   final String? token;
//   final DelivererModel? currentUser;

//   AuthState({required this.isAuthenticated, this.token, this.currentUser});

//   @override
//   List<Object?> get props => [isAuthenticated, token];

//   AuthState copyWith(
//       {bool? isAuthenticated, String? token, DelivererModel? currentUser}) {
//     return AuthState(
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated,
//       token: token ?? this.token,
//       currentUser: currentUser,
//     );
//   }

//   factory AuthState.fromJson(Map<String, dynamic> json) {
//     return AuthState(
//       isAuthenticated: json['isAuthenticated'],
//       token: json['token'],
//       currentUser: json['user'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'isAuthenticated': isAuthenticated,
//       'token': token,
//       'currentUser': currentUser!.toJson()
//     };
//   }
// }
