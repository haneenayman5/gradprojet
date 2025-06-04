import '../repositories/chat_repository.dart';
import '../entities/message.dart';

class ChatUseCase {
  final ChatRepository chatRepository;

  ChatUseCase(this.chatRepository);

  Future<void> connect() async => await chatRepository.connect();

  Future<void> sendMessage(ChatMessageEntity message) async {
    await chatRepository.sendMessage(message);
  }

  void onMessageReceived(Function(ChatMessageEntity) callback) {
    chatRepository.onMessageReceived(callback);
  }

  Future<List<ChatMessageEntity>> loadMessages(String sender, String receiver) async {
    final messages = await chatRepository.loadMessages(sender, receiver);
    messages.sort((a, b) => b.time.compareTo(a.time));
    return messages;
  }

  Future<List<ChatMessageEntity>> getCachedMessages(String sender, String receiver) async {
    return await chatRepository.getCachedMessages(sender, receiver);
  }

  Future<void> cacheMessages(String sender, String receiver, List<ChatMessageEntity> messages) async {
    await chatRepository.cacheMessages(sender, receiver, messages);
  }

  Future<void> disconnect() => chatRepository.disconnect();
}
