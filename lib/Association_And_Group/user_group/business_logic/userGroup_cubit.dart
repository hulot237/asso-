import 'package:faroty_association_1/Association_And_Group/association/business_logic/delivery_state.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_repository.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_one/proposition/business_logic/proposition_state.dart';
// import 'package:integration_part_one/proposition/data/proposition_repository.dart';

class UserGroupCubit extends Cubit<UserGroupState> {
  UserGroupCubit()
      : super(
          UserGroupState(
              userGroup: null,
              // userGroupDefault: null,
              ChangeAssData: null,
              isLoading: false),
        );

  Future<bool> AllUserGroupOfUserCubit() async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await UserGroupRepository().AllGroupOfUser();

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            usergroup: data,
            // usergroupdefault: state.userGroupDefault,
            changeassdata: state.ChangeAssData, isloading: false,
          ),
        );

        print("AllUserGroupOfUser Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            usergroup: [],
            changeassdata: state.ChangeAssData,
            // usergroupdefault: state.userGroupDefault,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          usergroup: [],
          changeassdata: state.ChangeAssData,
          // usergroupdefault: state.userGroupDefault,
          isloading: false,
        ),
      );
      return true;
    }
  }

  // Future<bool> UserGroupDefaultCubit(codeAssDefaul) async {
  //   try {
  //     final data = await UserGroupRepository().UserGroupDefault(codeAssDefaul);

  //     if (data != null) {
  //       // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

  //       // print("UserGroupDefaultCubit data in cubittttttttt ${data}");

  //       emit(
  //         state.copyWith(
  //           usergroupdefault: data,
  //           usergroup: state.userGroup,
  //           changeassdata: state.ChangeAssData,isloading: false,

  //         ),
  //       );

  //       print("UserGroupDefaultCubit Cubit ok");
  //       return true;
  //     } else {
  //       emit(
  //         state.copyWith(
  //           usergroupdefault: {},
  //           usergroup: state.userGroup,
  //           changeassdata: state.ChangeAssData,isloading: false,

  //         ),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         usergroupdefault: {},
  //         usergroup: state.userGroup,
  //           changeassdata: state.ChangeAssData,isloading: false,

  //       ),
  //     );
  //     return true;
  //   }
  // }

  Future<bool> ChangeAssCubit(codeAss) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await UserGroupRepository().ChangerAss(codeAss);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        print(
            "ChangeAssCubitChangeAssCubitChangeAssCubit data in cubittttttttt ${data}");

        emit(
          state.copyWith(
            changeassdata: data,
            // usergroupdefault: state.userGroupDefault,
            usergroup: state.userGroup,
            isloading: false,
          ),
        );

        print("UserGroupDefaultCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            changeassdata: {},
            // usergroupdefault: state.userGroupDefault,
            usergroup: state.userGroup, isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          changeassdata: {},
          // usergroupdefault: state.userGroupDefault,
          usergroup: state.userGroup, isloading: false,
        ),
      );
      return true;
    }
  }
}
