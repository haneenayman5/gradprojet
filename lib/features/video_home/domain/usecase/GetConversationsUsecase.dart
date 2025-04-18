import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/video_home/domain/repository/ChatHomeRepository.dart';

class GetConversationUsecase {
  final ChatHomeRepository chatHomeRepository;

  GetConversationUsecase({required this.chatHomeRepository});

  Future <List<ConversationEntity>> call() async {
    return chatHomeRepository.getConversations();
  }
}