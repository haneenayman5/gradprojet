import '../repositories/chat_repository.dart';
import '../entities/message.dart';

class ChatUseCase {
  final ChatRepository chatRepository;

  ChatUseCase(this.chatRepository);

  Future<void> connect() => chatRepository.connect();

  void sendMessage(ChatMessageEntity message) {
    chatRepository.sendMessage(message);
  }

  void onMessageReceived(Function(ChatMessageEntity) callback) {
    chatRepository.onMessageReceived(callback);
  }

  Future<List<ChatMessageEntity>> loadMessages(String sender, String receiver) async {
    final messages = await chatRepository.loadMessages(sender, receiver);
    messages.sort((a, b) => a.time.compareTo(b.time));
    return messages;

  }

  Future<void> disconnect() => chatRepository.disconnect();
}
