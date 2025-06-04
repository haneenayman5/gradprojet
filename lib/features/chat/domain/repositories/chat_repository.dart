import 'package:untitled3/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<void> connect();
  Future<void> disconnect();

  /// Send message asynchronously
  Future<void> sendMessage(ChatMessageEntity message);

  Future<List<ChatMessageEntity>> loadMessages(String senderId, String receiverId);

  void onMessageReceived(Function(ChatMessageEntity) callback);

  /// Added methods for caching messages locally
  Future<List<ChatMessageEntity>> getCachedMessages(String senderId, String receiverId);

  Future<void> cacheMessages(String senderId, String receiverId, List<ChatMessageEntity> messages);
}
