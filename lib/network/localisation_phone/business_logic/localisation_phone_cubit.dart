import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_repository.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_state.dart';
import 'package:faroty_association_1/network/localisation_phone/data/localisation_phone_repository.dart';

class LocalisationPhoneCubit extends Cubit<LocalisationPhoneState> {
  LocalisationPhoneCubit()
      : super(
          LocalisationPhoneState(
            localisationPhone: null,
            isLoading: false,
          ),
        );

  Future<void> showLocalisationPhone() async {
    print("LocalisationPhoneCubit");
    emit(
      state.copyWith(
        isLoading: true,
        localisationPhone: state.localisationPhone,
      ),
    );
    try {
      final data = await LocalisationPhoneRepository().fetchData();

      emit(
        state.copyWith(
          localisationPhone: data,
          isLoading: false,
        ),
      );
      print(state.localisationPhone);
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
