import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_state.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/tontine_perso_repository.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TontinePersoCubit extends Cubit<TontinePersoState> {
  TontinePersoCubit() : super(TontinePersoInitial());

  Future<void> fetchTontinePerso() async {
    emit(TontinePersoLoading(state.dataTontinePerso));
    try {
      final response = await TontinePersoRepository().getTontinePerso();
      if (response.statusCode == 200) {
        final data =
            response.data; // Assurez-vous de traiter correctement les données
            await AppCubitStorage().updateIsNoSubmit(false);
        emit(TontinePersoLoaded(data));
      } else if (response.statusCode == 404) {
       await AppCubitStorage().updateIsNoSubmit(true);
        emit(TontinePersoError(noSubmit: true));
      } else {
        emit(TontinePersoError());
      }
    } catch (e) {
      emit(TontinePersoError());
    }
  }

  bool get isNoSubmit {
    if (state is TontinePersoError) {
      return (state as TontinePersoError).noSubmit;
    }
    return false;
  }
}
