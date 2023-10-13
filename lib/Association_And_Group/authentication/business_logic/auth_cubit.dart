// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_two/authentication/data/auth_repository.dart';
// import 'package:integration_part_two/authentication/data/deliverer_model.dart';

// import 'auth_state.dart';

// class AuthCubit extends HydratedCubit<AuthState> {
//   AuthCubit() : super(AuthState(isAuthenticated: false));

//   Future<bool> login(String email, String password) async {
//     print(email);
//     print(password);
//     try {
//       final data = await AuthRepository().login(email, password);

//       if (data!['token'] != null) {
//         // Une fois la connexion réussie, mettez à jour l'état de l'authentification
//         emit(state.copyWith(isAuthenticated: true, token: data['token'], currentUser: DelivererModel.fromJson(data['user'])));
//         print("success cubit login");
//         return true;
//       } else {
//         print("lose cubit login");
//         emit(state.copyWith(isAuthenticated: false, token: null, currentUser: null));
//         return false;
//       }
//     } catch (e) {
//       print("e"+ e.toString());
//       emit(state.copyWith(isAuthenticated: false, token: null, currentUser: null));
//       return false;
//     }
//   }

//   void logout() {
//     // Effectuez votre logique de déconnexion ici

//     // Une fois la déconnexion réussie, mettez à jour l'état de l'authentification
//     emit(state.copyWith(isAuthenticated: false, token: null));
//   }

//   @override
//   AuthState? fromJson(Map<String, dynamic> json) {
//     try {
//       return AuthState.fromJson(json);
//     } catch (_) {
//       return null;
//     }
//   }

//   @override
//   Map<String, dynamic>? toJson(AuthState state) {
//     try {
//       return state.toJson();
//     } catch (_) {
//       return null;
//     }
//   }
// }
