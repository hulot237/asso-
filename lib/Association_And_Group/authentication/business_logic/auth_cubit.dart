import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          AuthState(
            detailUser: null,
            loginInfo: null,
            isLoading: false,
            isTrueNomber: null,
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
              isloading: false,
              istruenomber: state.isTrueNomber),
        );

        print("detailAuthCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
              detailuser: {},
              logininfo: state.loginInfo,
              isloading: false,
              istruenomber: state.isTrueNomber),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
            detailuser: {},
            logininfo: state.loginInfo,
            isloading: false,
            istruenomber: state.isTrueNomber),
      );
      return false;
    }
  }

  Future<bool> ConfirmationCubit(codeConfirmation) async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await AuthRepository().ConfirmationRepository(codeConfirmation);

      if (data != null) {
        emit(
          state.copyWith(
              logininfo: data,
              detailuser: state.detailUser,
              isloading: false,
              istruenomber: state.isTrueNomber),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
              logininfo: {},
              detailuser: state.detailUser,
              isloading: false,
              istruenomber: state.isTrueNomber),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
            logininfo: {},
            detailuser: state.detailUser,
            isloading: false,
            istruenomber: state.isTrueNomber),
      );
      return false;
    }
  }

  Future<bool> loginFirstCubit(phoneNumber) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await AuthRepository().LoginRepository(phoneNumber);

      if (data != null) {
        emit(
          state.copyWith(
            istruenomber: data,
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
            logininfo: {},
            detailuser: state.detailUser,
            istruenomber: true,
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
          istruenomber: true,
          isloading: false,
        ),
      );
      return false;
    }
  }
}
