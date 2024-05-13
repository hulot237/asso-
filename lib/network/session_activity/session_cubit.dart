import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/session_activity/session_repository.dart';
import 'package:faroty_association_1/network/session_activity/session_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit()
      : super(
          SessionState(detailSession: null, isValidSession: false),
        );
  Future<void> GetSessionCubit() async {
    emit(
      state.copyWith(
        detailSession: state.detailSession,
      ),
    );
    try {
      if (state.isValidSession == false) {
        final data = await SessionRepository().GetUseSesion();
        print("gggggggggggggggggggggggggggggg1 ${data}");
        await AppCubitStorage().updateXSessionId(data["hash_id"]);
        emit(
          state.copyWith(
            detailSession: data,
            isValidSession: true,
          ),
        );
      }else{
        // final data = await SessionRepository().GetUseSesion();
        // print("gggggggggggggggggggggggggggggg1 ${data}");
        // // await AppCubitStorage().updateXSessionId(null);
        // emit(
        //   state.copyWith(
        //     detailSession: AppCubitStorage().state.,
        //   ),
        // );
      }

      print(" jjjjjjjjj ${AppCubitStorage().state.xSessionId}");
    } catch (e) {
      emit(
        state.copyWith(
          detailSession: null,
          // isloading: false,
        ),
      );
    }
  }
}
