import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SeanceCubit extends Cubit<SeanceState> {
  SeanceCubit()
      : super(
          SeanceState(
            detailSeance: null,
          ),
        );

  Future<bool> detailSeanceCubit(codeSeance) async {
    try {
      final data =
          await SeanceRepository().DetailSeance(codeSeance);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailseance: data,
          ),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailseance: {},
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailseance: {},
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
