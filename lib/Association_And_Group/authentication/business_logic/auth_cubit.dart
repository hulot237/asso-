import 'dart:convert';

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
            dataCookies: null,
            alreadyShow: 0,
          ),
        );

  Future<void> detailAuthCubit(userCode, codeTournoi) async {
    emit(state.copyWith(
      isLoadingDetailUser: true,
      isLoading: true,
      detailUser: state.detailUser,
      isTrueNomber: state.isTrueNomber,
      alreadyShow: state.alreadyShow,
      loginInfo: state.loginInfo,
      errorLoadDetailAuth: state.errorLoadDetailAuth,
      // alreadyShow: state.alreadyShow
    ));
    try {
      final data = await AuthRepository().UserDetail(userCode, codeTournoi);

      emit(
        state.copyWith(
          detailUser: data,
          loginInfo: state.loginInfo,
          isLoading: false,
          isTrueNomber: state.isTrueNomber,
          alreadyShow: state.alreadyShow,
          isLoadingDetailUser: false,
          errorLoadDetailAuth: false,
          // alreadyShow: 2
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailUser: {},
          loginInfo: state.loginInfo,
          isLoading: false,
          isTrueNomber: state.isTrueNomber,
          alreadyShow: state.alreadyShow,
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

  Future<void> loginFirstCubit(phoneNumber, countryCode) async {
    emit(state.copyWith(
      isLoading: true,
      isLoadingDetailUser: false,
      detailUser: state.detailUser,
      isTrueNomber: state.isTrueNomber,
      loginInfo: state.loginInfo,
      alreadyShow: state.alreadyShow,
    ));
    try {
      final data = await AuthRepository().LoginRepository(phoneNumber, countryCode);

      emit(
        state.copyWith(
          isTrueNomber: data,
          loginInfo: state.loginInfo,
          detailUser: state.detailUser,
          isLoading: false,
          isLoadingDetailUser: false,
          alreadyShow: state.alreadyShow!+1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          //loginInfo: {},
          detailUser: state.detailUser,
          isTrueNomber: true,
          isLoading: false,
          isLoadingDetailUser: false,
          alreadyShow: state.alreadyShow!+1,
        ),
      );
    }
  }
  void updateAlreadyShow(int value) {
    emit(state.copyWith(alreadyShow: value));
  }


  String userDataFromWebView = 'null';

  String dataForCookies(getUid) {
    if (getUid == null) return '';

    Map<String, dynamic> data =
        json.decode(userDataFromWebView) ?? json.decode(getUid!);

    return json.encode(
      {
        "user": {
          "is_confirm": data['user']['is_confirm'],
          "is_wallet_confirm": data['user']['is_wallet_confirm'],
          "hash_id": data['user']['hashid'],
        },
        "api_token": data['api_token'],
        "api_password": data['api_password']
      },
    );
  }

  Future<void> getUid() async {
    try {
      final data = await AuthRepository().getUid();
      final dataCookies = await dataForCookies(data);

      emit(
        state.copyWith(
          getUid: data,
          dataCookies: dataCookies,
        ),
      );
      print("getUid getUid getUid getUid ${state.getUid}");
      print(
          "dataCookies dataCookies dataCookies dataCookies ${state.dataCookies}");
    } catch (e) {
      print("erreur cubit getUid");
    }
  }
}
