import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthUpdateCubit extends Cubit<AuthUpdateState> {
  AuthUpdateCubit()
      : super(
          AuthUpdateState(
            updateInfoUser: null,
            isLoading: false,
          ),
        );


  Future<bool> UpdateInfoUserCubit(
      key, value, partner_urlcode, membre_code) async {
    emit(state.copyWith(isloading: true));

    try {
      final data = await AuthRepository()
          .UpdateInfoUserRepository(key, value, partner_urlcode, membre_code);

      if (data != null) {
        emit(
          state.copyWith(
            updateinfouser: data,
            isloading: false,
          ),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            updateinfouser: {},
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          updateinfouser: {},
          isloading: false,
        ),
      );
      return false;
    }
  }
}
