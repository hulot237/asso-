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
            isLoadingDetailEpargne: false,
            detailEpargne: null,
            pret: null,
            isLoadingPret: false,
            isLoadingDetailPret: false,
            detailPret: null,
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

  Future<void> getPret() async {
    emit(state.copyWith(isLoadingPret: true, pret: state.pret));
    try {
      final data = await PretEpargneRepository().getPret();

      emit(
        state.copyWith(
          pret: data,
          isLoadingPret: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingPret: false,
          messageError: e.toString(),
        ),
      );
    }
  }

  Future<void> getAllAssEpargnes(codeTournois) async {
    emit(state.copyWith(isLoadingAllAssEpargne: true, allAssEpargne: state.allAssEpargne));
    try {
      final data = await PretEpargneRepository().getAllAssEpargnes(codeTournois);

      emit(
        state.copyWith(
          allAssEpargne: data,
          isLoadingAllAssEpargne: false,
        ),
      );
      print("ee ${state.allAssEpargne}");
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingAllAssEpargne: false,
          messageError: e.toString(),
        ),
      );
      print("${state.allAssEpargne}");

    }
  }

  Future<void> getDetailEpargne(codeEpargne) async {
    emit(state.copyWith(
        isLoadingDetailEpargne: true, detailEpargne: state.detailEpargne));

    try {
      final data = await PretEpargneRepository().getDetailEpargne(codeEpargne);
      emit(
        state.copyWith(
          detailEpargne: data,
          isLoadingDetailEpargne: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingDetailEpargne: false,
          messageError: e.toString(),
        ),
      );
    }
  }

  Future<void> getDetailPret(codePret) async {
    emit(state.copyWith(
        isLoadingDetailPret: true, detailPret: state.detailPret));

    try {
      final data = await PretEpargneRepository().getDetailPret(codePret);
      emit(
        state.copyWith(
          detailPret: data,
          isLoadingDetailPret: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingDetailPret: false,
          messageError: e.toString(),
        ),
      );
    }
  }
}
