import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/data/help_center_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit()
      : super(
          HelpCenterState(
              allCategorieHelp: null,
              allTopicsHelp: null,
              allCategorieTopicHelp: null,
              isLoading: false,
              isLoadingTransaction: false),
        );

  Future<void> AllHelpCategorie() async {
    print("response CategoriesHelpModel1");
    emit(
      state.copyWith(
        isLoading: true,
        allCategorieHelp: state.allCategorieHelp,
      ),
    );

    try {
      final data = await HelpCenterRepository().AllHelpCategorie();

      emit(state.copyWith(
        isLoading: false,
        allCategorieHelp: data,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        isLoading: false,
        allCategorieHelp: [],
      ));
    }
  }

  Future<void> DetailHelpTopic(categorieId) async {
    emit(
      state.copyWith(
        isLoading: true,
        allTopicsHelp: state.allTopicsHelp,
      ),
    );

    try {
      final data = await HelpCenterRepository().AllHelpTopic(categorieId);

      emit(state.copyWith(
        isLoading: false,
        allTopicsHelp: data,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        isLoading: false,
        allTopicsHelp: [],
      ));
    }
  }

  Future<void> DetailHelpCategorie(categorieId) async {
    print("response CategoriesTopicsHelpModel1");
    emit(
      state.copyWith(
        isLoading: true,
        allCategorieHelp: state.allCategorieHelp,
        allCategorieTopicHelp: state.allCategorieTopicHelp,
      ),
    );

    try {
      final data =
          await HelpCenterRepository().DetailHelpCategorie(categorieId);

      emit(state.copyWith(
        isLoading: false,
        allCategorieTopicHelp: data,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}
