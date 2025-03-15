import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/chat/domain/entities/message.dart';
import 'package:untitled3/features/chat/domain/usecases/chat_usecase.dart';
import 'package:untitled3/features/chat/presentation/blocs/chat_events.dart';

import 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase chatUseCase;

  ChatBloc({required this.chatUseCase}) : super(ChatInitial()){
    on<ChatMessageReceived>((event, emit) async {
      emit(ChatAddingMessage(message: event.message));
    });

    on<ChatSendMessage>((event, emit) async {
      chatUseCase.sendMessage(event.message);
      emit(ChatAddingMessage(message: event.message));
    });
    
    on<ChatLoadMessages>((event, emit) async {
      emit(ChatLoading());
      try{
        await chatUseCase.connect();
        final messages = await chatUseCase.loadMessages(event.sender, event.receiver);

        chatUseCase.onMessageReceived((ChatMessageEntity message) {
          add(ChatMessageReceived(message: message));
        });

        emit(ChatMessagesLoadingSuccess(messages: messages));
      }
      catch(e) {
        emit(ChatMessagesLoadingFailure(error: e.toString()));
      }
    });

    on<ChatUpdateMessages>((event, emit) async {
      emit(ChatUpdating());
    });

    on<ChatDisconnect>((event, emit) async {
      try{
        await chatUseCase.disconnect();
      }
      catch(e) {
        rethrow;
      }
    });

  }

}