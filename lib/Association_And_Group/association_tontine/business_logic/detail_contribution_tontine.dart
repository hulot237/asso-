import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/association_tontine_repository.dart';

class DetailContributionCubit extends Cubit<ContributionState> {
  DetailContributionCubit()
      : super(
          ContributionState(
            isLoadingContibutionTontine: false,
            detailContributionTontine: null,
          ),
        );

  Future<bool> detailContributionTontineCubit(codeContribution) async {
    emit(state.copyWith( isloadingcontibutionTontine: true));
    try {
      final data = await TontineRepository().DetailContributionTontine(codeContribution);

      if (data != null) {
        emit(
          state.copyWith(
            detailcontributiontontine: data,
              isloadingcontibutionTontine: false),
        );

        print("detailContributionTontineCubit Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailcontributiontontine: {},
              isloadingcontibutionTontine: false),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailcontributiontontine: {},
            isloadingcontibutionTontine: false),
      );
      return true;
    }
  }
}
