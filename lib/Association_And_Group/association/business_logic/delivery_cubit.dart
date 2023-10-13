// import 'package:faroty_association_1/Association_And_Group/association/business_logic/delivery_state.dart';
// import 'package:faroty_association_1/Association_And_Group/association/data/association_repository.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_one/proposition/business_logic/proposition_state.dart';
// import 'package:integration_part_one/proposition/data/proposition_repository.dart';

// class AssociationCubit extends Cubit<AssociationState> {
//   AssociationCubit() : super(AssociationState(association: []));

//   Future<bool> AllAssociationOfUserCubit(int serviceId) async {
//     try {
//       final data = await AssociationRepository().AllAssociationOfUser();

//       if (data != null) {
//         // Une fois la connexion réussie, mettez à jour l'état de l'authentification
//         emit(state.copyWith(association: data));

//         return true;
//       } else {
//         emit(state.copyWith(association: []));
//         return false;
//       }
//     } catch (e) {
//       emit(state.copyWith(association: []));
//       return true;
//     }
//   }

  // Future<bool> propositionRejet(int propositionId) async {
  //   try {
  //     final data =
  //         await PropositionRepository().propositionRejet(propositionId);

  //     if (!data['error']) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> propositionAccept(int propositionId) async {
  //   try {
  //     final data =
  //         await PropositionRepository().propositionAccept(propositionId);

  //     if (!data['error']) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // @override
  // ServiceState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     return ServiceState.fromJson(json);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(ServiceState state) {
  //   try {
  //     return state.toJson();
  //   } catch (_) {
  //     return null;
  //   }
  // }
// }
