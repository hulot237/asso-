import 'package:faroty_association_1/Association_And_Group/association/business_logic/delivery_state.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_repository.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_one/proposition/business_logic/proposition_state.dart';
// import 'package:integration_part_one/proposition/data/proposition_repository.dart';

class DetailTournoiCourantCubit extends Cubit<DetailTournoiCourantState> {
  DetailTournoiCourantCubit()
      : super(
          DetailTournoiCourantState(
            detailtournoiCourant: {},
            
          ),
        );

  Future<bool> detailTournoiCourantCubit() async {
    try {
      final data = await DetailTournoiCourantRepository().DetailTournoiCourant();

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailtournoicourant: data,
          ),
        );

        print("detailtournoicourant Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailtournoicourant: {},
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailtournoicourant: {},
        ),
      );
      return true;
    }
  }

  // Future<bool> UserGroupDefaultCubit() async {
  //   try {
  //     final data = await UserGroupRepository().UserGroupDefault();

  //     if (data != null) {
  //       // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

  //       print("UserGroupDefaultCubit data in cubittttttttt ${data}");

  //       emit(
  //         state.copyWith(
  //           usergroupdefault: data,
  //           usergroup: state.userGroup,
  //         ),
  //       );

  //       print("UserGroupDefaultCubit Cubit ok");
  //       return true;
  //     } else {
  //       emit(
  //         state.copyWith(
  //           usergroupdefault: {},
  //           usergroup: state.userGroup,
  //         ),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         usergroupdefault: {},
  //         usergroup: state.userGroup,
  //       ),
  //     );
  //     return true;
  //   }
  // }
}