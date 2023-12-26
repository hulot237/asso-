


import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/association_payements_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/data/association_payements_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class tokenNotificationCubit extends Cubit<tokenNotificationState> {
  tokenNotificationCubit()
      : super(
          tokenNotificationState(
            tokenNotification: null,
          ),
        );

  Future<bool> tokenNotificationCubitt(token) async {
    try {

      if (token != null) {
        emit(
          state.copyWith(
            tokennotification: token,
          ),
        );

        print("tokennotification Cubit ok");

        return true;
      } else {
        emit(
          state.copyWith(
            tokennotification: '',
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          tokennotification: '',
        ),
      );
      return true;
    }
  }
}
