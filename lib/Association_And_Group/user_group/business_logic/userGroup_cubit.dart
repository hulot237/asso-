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
              changeAssData: null,
              isLoading: false,
              isLoadingChangeAss: false),
        );

  Future<bool> AllUserGroupOfUserCubit(token) async {
    emit(
      state.copyWith(
        isLoading: true,
        userGroup: state.userGroup,
        changeAssData: state.changeAssData,
      ),
    );
    try {
      final data = await UserGroupRepository().AllGroupOfUser(token);

      if (data != null) {
        emit(
          state.copyWith(
            userGroup: data,
            changeAssData: state.changeAssData,
            isLoading: false,
          ),
        );

        print("AllUserGroupOfUser Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            userGroup: [],
            changeAssData: state.changeAssData,
            isLoading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          userGroup: [],
          changeAssData: state.changeAssData,
          isLoading: false,
        ),
      );
      return true;
    }
  }

  Future<void> ChangeAssCubit(codeAss) async {
    emit(
      state.copyWith(
        changeAssData: state.changeAssData,
        isLoadingChangeAss: true,
        userGroup: state.userGroup,
      ),
    );
    try {
      final data = await UserGroupRepository().ChangerAss(codeAss);

      emit(
        state.copyWith(
          changeAssData: data,
          userGroup: state.userGroup,
          isLoadingChangeAss: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingChangeAss: false,
        ),
      );
    }
  }
}
