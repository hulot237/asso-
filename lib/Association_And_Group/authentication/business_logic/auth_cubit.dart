import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          AuthState(detailUser: null, loginInfo: null),
        );

  Future<bool> detailAuthCubit(userCode) async {
    try {
      final data = await AuthRepository().UserDetail(userCode);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailuser: data,
            logininfo: state.loginInfo
          ),
        );

        print("detailAuthCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailuser: {},
            logininfo: state.loginInfo
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailuser: {},
          logininfo: state.loginInfo
        ),
      );
      return false;
    }
  }

  Future<bool> LoginCubit(numeroPhone) async {
    try {
      final data = await AuthRepository().LoginRepository(numeroPhone);

      if (data != null) {

        emit(
          state.copyWith(
            logininfo: data,
            detailuser: state.detailUser,
          ),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            logininfo: {},
            detailuser: state.detailUser,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          logininfo: {},
          detailuser: state.detailUser,
        ),
      );
      return false;
    }
  }
}
