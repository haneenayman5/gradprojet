import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/home/domain/usecase/GetConversationsUsecase.dart';
import 'package:untitled3/features/home/domain/usecase/GetSenderIdUsecase.dart';
import 'package:untitled3/features/home/presentation/bloc/chat_home_events.dart';
import 'package:untitled3/features/home/presentation/bloc/chat_home_states.dart';

class ChatHomeBloc extends Bloc<ChatHomeEvent, ChatHomeState> {
  final GetConversationUsecase getConversationUsecase;
  final GetSenderIdUseCase getSenderIdUseCase;

  ChatHomeBloc({required this.getConversationUsecase, required this.getSenderIdUseCase}) : super(ChatHomeInitial()){
    on<ChatHomeLoadConversation>((event, emit) async {
      try {
        var conversations = await getConversationUsecase.call();
        var senderId = await getSenderIdUseCase();
        emit(ChatHomeLoadingConversationsSuccessful(conversations: conversations, senderId: senderId));
      }
      catch(e)
      {
        print("error in getting conversations " + e.toString());
        emit(ChatConversationsLoadingFailure(error: e.toString()));
      }
    });
  }

}