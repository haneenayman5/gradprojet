import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searchusers_state.dart';

class SearchusersCubit extends Cubit<SearchusersState> {
  SearchusersCubit() : super(SearchusersInitial(names: namesUser));

  void filterNames({required String name}) {
    if (name.isEmpty) {
      emit(SearchusersInitial(names: namesUser));
    } else {
      emit(SearchusersLoading());
      final filteredList = namesUser
          .where(
            (filterName) => filterName
                .toString()
                .toLowerCase()
                .contains(name.toLowerCase()),
          )
          .toList();
      if (filteredList.isNotEmpty) {
        emit(SearchusersFilter(filterNames: filteredList));
      } else {
        emit(SearchusersFailure());
      }
    }
  }
}
