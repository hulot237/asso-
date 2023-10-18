import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          AuthState(detailUser: {}),
        );

  Future<bool> detailAuthCubit(userCode) async {
    try {
      final data =
          await AuthRepository().UserDetail(userCode);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailuser: data,
          ),
        );

        print("detailAuthCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailuser: {},
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailuser: {},
        ),
      );
      return true;
    }
  }
}