import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_repository.dart';

class MembreCubit extends Cubit<MembreState> {
  MembreCubit()
      : super(
          MembreState(
            allMembers: null,
            isLoading: false,
          ),
        );

  Future<bool> showMembersAss(codeAssociation) async {
    emit(state.copyWith(isloading: true, allmembers: state.allMembers));
    try {
      final data = await MembersRepository().showMembersAss(codeAssociation);

      if (data != null) {
        emit(
          state.copyWith(
            allmembers: data,
            isloading: false,
          ),
        );
        return true;
      } else {
        emit(
          state.copyWith(
            allmembers: [],
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          allmembers: [],
          isloading: false,
        ),
      );
      return true;
    }
  }
}
