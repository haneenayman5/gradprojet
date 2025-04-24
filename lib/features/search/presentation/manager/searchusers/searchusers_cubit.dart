import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetConversationsUsecase.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetSenderIdUsecase.dart';

part 'searchusers_state.dart';

class SearchusersCubit extends Cubit<SearchusersState> {
  SearchusersCubit(this.getConversationUsecase, this.getSenderIdUseCase)
      : super(SearchusersInitial());

  final GetConversationUsecase getConversationUsecase;
  final GetSenderIdUseCase getSenderIdUseCase;

  void filterNames({required String name}) async {
    var conversations = await getConversationUsecase.call();
    var senderId = await getSenderIdUseCase();
    if (name.isEmpty) {
      emit(SearchusersInitial());
    } else {
      emit(SearchusersLoading());
      final filteredList = conversations
          .where(
            (filterName) => filterName
                .toString()
                .toLowerCase()
                .contains(name.toLowerCase()),
          )
          .toList();
      if (filteredList.isNotEmpty) {
        emit(SearchusersFilter(filterNames: filteredList, senderId));
      } else {
        emit(SearchusersFailure());
      }
    }
  }
}
