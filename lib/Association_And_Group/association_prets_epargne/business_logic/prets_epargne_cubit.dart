import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/data/association_payements_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/data/prets_epargne_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PretEpargneCubit extends Cubit<PretEpargneState> {
  PretEpargneCubit()
      : super(
          PretEpargneState(
            epargne: null,
            isLoadingEpargne: false,
            nomberNotif: null,
          ),
        );

  Future<void> getEpargne() async {
    emit(state.copyWith(isLoadingEpargne: true, epargne: state.epargne));
    try {
      final data = await PretEpargneRepository().getEpargne();

      emit(
        state.copyWith(
          epargne: data,
          isLoadingEpargne: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingEpargne: false,
          messageError: e.toString(),
        ),
      );
    }
  }

  // Future<void> countNotification() async {
  //   emit(state.copyWith(isLoadingNomberNotif: true, notifications: state.notifications));
  //   try {
  //     final data = await NotificationRepository().countNotification();

  //     emit(
  //       state.copyWith(
  //         nomberNotif: data,
  //         isLoadingNomberNotif: false,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         isLoadingNomberNotif: false,
  //         messageError: e.toString(),
  //       ),
  //     );
  //   }
  // }
}
