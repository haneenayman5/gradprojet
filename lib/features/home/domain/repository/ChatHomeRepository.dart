import 'package:untitled3/features/home/domain/entity/ConversationEntity.dart';

abstract class ChatHomeRepository {
  Future<List<ConversationEntity>> getConversations();
  Future<String> getSenderId();
}