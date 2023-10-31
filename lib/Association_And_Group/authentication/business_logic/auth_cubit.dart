import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          AuthState(
            detailUser: null,
            loginInfo: null,
            updateInfoUser: null,
            isLoading: false,
          ),
        );

  Future<bool> detailAuthCubit(userCode) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await AuthRepository().UserDetail(userCode);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailuser: data,
            logininfo: state.loginInfo,
            updateinfouser: state.updateInfoUser,
            isloading: false,
          ),
        );

        print("detailAuthCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailuser: {},
            logininfo: state.loginInfo,
            updateinfouser: state.updateInfoUser,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailuser: {},
          logininfo: state.loginInfo,
          updateinfouser: state.updateInfoUser,
          isloading: false,
        ),
      );
      return false;
    }
  }

  Future<bool> LoginCubit(numeroPhone) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await AuthRepository().LoginRepository(numeroPhone);

      if (data != null) {
        emit(
          state.copyWith(
            logininfo: data,
            detailuser: state.detailUser,
            updateinfouser: state.updateInfoUser,
            isloading: false,
          ),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            logininfo: {},
            detailuser: state.detailUser,
            updateinfouser: state.updateInfoUser,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          logininfo: {},
          detailuser: state.detailUser,
          updateinfouser: state.updateInfoUser,
          isloading: false,
        ),
      );
      return false;
    }
  }

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
            logininfo: state.loginInfo,
            detailuser: state.detailUser,
            isloading: false,
          ),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            updateinfouser: {},
            logininfo: state.loginInfo,
            detailuser: state.detailUser,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          updateinfouser: {},
          logininfo: state.loginInfo,
          detailuser: state.detailUser,
          isloading: false,
        ),
      );
      return false;
    }
  }
}
