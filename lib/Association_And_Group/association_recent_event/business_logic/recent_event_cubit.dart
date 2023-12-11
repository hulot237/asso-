import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/data/association_recent_event_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class RecentEventCubit extends Cubit<RecentEventState> {
  RecentEventCubit()
      : super(
          RecentEventState(
            allRecentEvent: null,
            isLoading: false,
          ),
        );
  Future<bool> AllRecentEventCubit(codeMembre) async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await RecentEventRepository().RecentEvent(codeMembre);

      if (data != null) {
        emit(
          state.copyWith(
            allrecentEvent: data,
            isloading: false,
          ),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            allrecentEvent: {},
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          allrecentEvent: {},
          isloading: false,
        ),
      );
      return true;
    }
  }
}
