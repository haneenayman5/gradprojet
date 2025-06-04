import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/chat/domain/entities/message.dart';
import 'package:untitled3/features/chat/domain/usecases/chat_usecase.dart';
import 'chat_events.dart';
import 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase chatUseCase;
  final List<ChatMessageEntity> _messages = [];

  ChatBloc({required this.chatUseCase}) : super(ChatInitial()) {
    on<ChatMessageReceived>((event, emit) {
      _messages.insert(0, event.message);
      emit(ChatUpdating(messages: List.from(_messages)));
    });

    on<ChatSendMessage>((event, emit) async {
      await chatUseCase.sendMessage(event.message);
      _messages.insert(0, event.message);
      emit(ChatUpdating(messages: List.from(_messages)));
    });

    on<ChatLoadMessages>((event, emit) async {
      try {
        // Register listener first to catch new messages during load
        chatUseCase.onMessageReceived((message) {
          add(ChatMessageReceived(message: message));
        });

        // Try to get cached messages first (implement getCachedMessages in your usecase)
        final cachedMessages = await chatUseCase.getCachedMessages(event.sender, event.receiver);

        if (cachedMessages.isNotEmpty) {
          _messages.clear();
          _messages.addAll(cachedMessages);
          emit(ChatMessagesLoadingSuccess(messages: List.from(_messages)));
        } else {
          emit(ChatLoading());
        }

        // Load fresh messages from backend
        final freshMessages = await chatUseCase.loadMessages(event.sender, event.receiver);
        _messages.clear();
        _messages.addAll(freshMessages);

        // Cache fresh messages (implement cacheMessages in your usecase)
        await chatUseCase.cacheMessages(event.sender, event.receiver, freshMessages);

        emit(ChatMessagesLoadingSuccess(messages: List.from(_messages)));
      } catch (e) {
        emit(ChatMessagesLoadingFailure(error: e.toString()));
      }
    });

    on<ChatUpdateMessages>((event, emit) {
      emit(ChatUpdating(messages: List.from(_messages)));
    });

    on<ChatDisconnect>((event, emit) async {
      await chatUseCase.disconnect();
    });
  }
}
