import 'dart:convert';

import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
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
      print("ztu $data");

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
      print("ztu ${state.detailUser}");
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

//
  Future<void> loginInfoConnectToWebViewFirst() async {
    emit(
      state.copyWith(
        errorLoading: false,
        successLoading: false,
        loginInfo: state.loginInfo,
      ),
    );
    try {
      final data =
          await AuthRepository().loginInfoConnectToWebViewFirstRepository(
        AppCubitStorage().state.userNameKey,
        AppCubitStorage().state.passwordKey,
      );
      emit(
        state.copyWith(
          loginInfo: data,
          errorLoading: false,
          successLoading: true,
        ),
      );
      print("loginInfo ${state.loginInfo}");
    } catch (e) {
      emit(
        state.copyWith(
            errorLoading: true, message: e.toString(), successLoading: false),
      );
    }
  }



    String userDataFromWebView2 = 'null';

  String dataForCookies2(getUid) {
    if (getUid == null) return '';

    Map<String, dynamic> data =
        json.decode(userDataFromWebView2) ?? json.decode(getUid!);

    return json.encode(
      {
        "user": {
          "is_confirm": data['user']['is_confirm'],
          "is_wallet_confirm": data['user']['is_wallet_confirm'],
          "hash_id": data['user']['hash_id'],
          "api_token": data['user']['api_token'],
          "api_password": data['api_password'],
        },
        "api_token": data['user']['api_token'],
        "api_password": data['api_password']
      },
    );
  }


  Future<void> ConfirmationForCreateRepository(confirmCode) async {
    emit(
      state.copyWith(
        dataCookies: state.dataCookies,
        isLoading: true,
        isLoadingDetailUser: false,
        errorLoading: false,
        successLoading: false,
      ),
    );
    try {
      final dataUID = await AuthRepository().ConfirmationForCreateRepository(confirmCode);
      final dataCookies = await dataForCookies2(dataUID);


      await AppCubitStorage().updateDataCookies(dataCookies);

      emit(
        state.copyWith(
          // loginInfo: data,
          isLoading: false,
          dataCookies: (dataCookies),
          // dataCookies: (dataCookies),
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
      final data =
          await AuthRepository().LoginRepository(phoneNumber, countryCode);

      emit(
        state.copyWith(
          isTrueNomber: data,
          loginInfo: state.loginInfo,
          detailUser: state.detailUser,
          isLoading: false,
          isLoadingDetailUser: false,
          alreadyShow: state.alreadyShow! + 1,
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
          alreadyShow: state.alreadyShow! + 1,
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
          "api_token": data['api_token'],
          "api_password": data['api_password'],
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
          // dataCookies: (dataCookies),
          dataCookies: (dataCookies),
        ),
      );
    } catch (e) {
      print("erreur cubit getUid");
    }
  }
}
