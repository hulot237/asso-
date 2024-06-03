import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_repository.dart';

class DetailContributionCubit extends Cubit<ContributionState> {
  DetailContributionCubit()
      : super(
          ContributionState(
            isLoadingContibutionTontine: false,
            detailContributionTontine: null,
          ),
        );

  Future<void> detailContributionTontineCubit(codeContribution) async {
    emit(state.copyWith( isloadingcontibutionTontine: true));
    try {
      final data = await TontineRepository().DetailContributionTontine(codeContribution);
      print("widgetDetailHistoriqueTontineCard $codeContribution");

        emit(
          state.copyWith(
            detailcontributiontontine: data,
              isloadingcontibutionTontine: false),
        );

        print("detailContributionTontineCubit Cubit ok");
        
    } catch (e) {
      emit(
        state.copyWith(
          detailcontributiontontine: {},
            isloadingcontibutionTontine: false),
      );
    }
  }
}
