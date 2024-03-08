import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_repository.dart';

class TontineCubit extends Cubit<TontineState> {
  TontineCubit()
      : super(
          TontineState(
            detailTontine: null,
            isLoading: false,
            errorLoadDetailTontine: false,
          ),
        );

  Future<void> detailTontineCubit(codeTournoi, codeTontine) async {
    emit(
      state.copyWith(
        isLoading: true,
        detailTontine: state.detailTontine,
        errorLoadDetailTontine: state.errorLoadDetailTontine,
      ),
    );
    try {
      final data =
          await TontineRepository().DetailTontine(codeTournoi, codeTontine);

      emit(
        state.copyWith(
          detailTontine: data,
          isLoading: false,
          errorLoadDetailTontine : false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorLoadDetailTontine: true,
        ),
      );
    }
  }
}
