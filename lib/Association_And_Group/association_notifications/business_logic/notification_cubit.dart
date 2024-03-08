import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/data/association_payements_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(
          NotificationState(
            tokenNotification: null,
            notifications: null,
            nomberNotif: null,
            errorLoadNotif: false,
          ),
        );

  Future<bool> tokenNotificationCubitt(token) async {
    try {
      if (token != null) {
        emit(
          state.copyWith(
            tokenNotification: token,
          ),
        );

        return true;
      } else {
        emit(
          state.copyWith(
            tokenNotification: '',
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          tokenNotification: '',
        ),
      );
      return true;
    }
  }

  Future<void> getNotification(tokenUser, codeAssociation) async {
    emit(
      state.copyWith(
        isLoading: true,
        notifications: state.notifications,
        errorLoadNotif: state.errorLoadNotif,
      ),
    );
    try {
      final data = await NotificationRepository().getNotification(tokenUser, codeAssociation);

      emit(
        state.copyWith(
          notifications: data,
          isLoading: false,
          errorLoadNotif: false,
        ),
      );
    } catch (e) {
      print("erreuuuuuuur ${e}");
      emit(
        state.copyWith(
          isLoading: false,
          errorLoadNotif: true,
          messageError: e.toString(),
        ),
      );
    }
  }

  Future<void> countNotification() async {
    emit(state.copyWith(
        isLoadingNomberNotif: true, notifications: state.notifications));
    try {
      final data = await NotificationRepository().countNotification();

      emit(
        state.copyWith(
          nomberNotif: data,
          isLoadingNomberNotif: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingNomberNotif: false,
          messageError: e.toString(),
        ),
      );
    }
  }
}
