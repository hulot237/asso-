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
            isLoadingDetailUser: false,
            isTrueNomber: null,
            getUid: null,
            errorLoadDetailAuth: false,
          ),
        );

  Future<void> detailAuthCubit(userCode, codeTournoi) async {
    emit(state.copyWith(
      isLoadingDetailUser: true,
      isLoading: true,
      detailUser: state.detailUser,
      isTrueNomber: state.isTrueNomber,
      loginInfo: state.loginInfo,
      errorLoadDetailAuth: state.errorLoadDetailAuth,
    ));
    try {
      final data = await AuthRepository().UserDetail(userCode, codeTournoi);

      emit(
        state.copyWith(
          detailUser: data,
          loginInfo: state.loginInfo,
          isLoading: false,
          isTrueNomber: state.isTrueNomber,
          isLoadingDetailUser: false,
          errorLoadDetailAuth: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailUser: {},
          loginInfo: state.loginInfo,
          isLoading: false,
          isTrueNomber: state.isTrueNomber,
          isLoadingDetailUser: false,
          errorLoadDetailAuth: true,
        ),
      );
    }
  }

  Future<void> confirmationCubit(codeConfirmation) async {
    emit(
      state.copyWith(
        isLoading: true,
        isLoadingDetailUser: false,
        errorLoading: false,
        successLoading: false,
      ),
    );
    try {
      final data =
          await AuthRepository().ConfirmationRepository(codeConfirmation);

      emit(
        state.copyWith(
          loginInfo: data,
          isLoading: false,
          isLoadingDetailUser: false,
          errorLoading: false,
          successLoading: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
            isLoading: false,
            isLoadingDetailUser: false,
            errorLoading: true,
            message: e.toString(),
            successLoading: false),
      );
    }
  }

  Future<void> loginInfoConnectToWebViewFirst(apiToken, apiPassword) async {
    emit(
      state.copyWith(
        isLoading: true,
        isLoadingDetailUser: false,
        errorLoading: false,
        successLoading: false,
      ),
    );
    try {
      final data =
          await AuthRepository().loginInfoConnectToWebViewFirstRepository(
        apiToken,
        apiPassword,
      );

      emit(
        state.copyWith(
          loginInfo: data,
          isLoading: false,
          isLoadingDetailUser: false,
          errorLoading: false,
          successLoading: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
            isLoading: false,
            isLoadingDetailUser: false,
            errorLoading: true,
            message: e.toString(),
            successLoading: false),
      );
    }
  }

  Future<bool> loginFirstCubit(phoneNumber, countryCode) async {
    emit(state.copyWith(
      isLoading: true,
      isLoadingDetailUser: false,
      detailUser: state.detailUser,
      isTrueNomber: state.isTrueNomber,
      loginInfo: state.loginInfo,
    ));
    try {
      final data =
          await AuthRepository().LoginRepository(phoneNumber, countryCode);

      if (data != null) {
        emit(
          state.copyWith(
            isTrueNomber: data,
            loginInfo: state.loginInfo,
            detailUser: state.detailUser,
            isLoading: false,
            isLoadingDetailUser: false,
          ),
        );

        print("detailAuthCubittttttttttttttttttt Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            //loginInfo: {},
            detailUser: state.detailUser,
            isTrueNomber: true,
            isLoading: false,
            isLoadingDetailUser: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          //loginInfo: {},
          detailUser: state.detailUser,
          isTrueNomber: true,
          isLoading: false,
          isLoadingDetailUser: false,
        ),
      );
      return false;
    }
  }

  Future<void> getUid() async {
    try {
      final data = await AuthRepository().getUid();

      emit(
        state.copyWith(
          getUid: data,
        ),
      );
      print("getUid getUid getUid getUid ${state.getUid}");
    } catch (e) {
      print("erreur cubit getUid");
    }
  }
}
