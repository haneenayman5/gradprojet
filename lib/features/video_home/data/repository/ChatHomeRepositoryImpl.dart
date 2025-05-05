import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/video_home/data/data_source/ConversationService.dart';
import 'package:untitled3/features/video_home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/video_home/domain/repository/ChatHomeRepository.dart';

class ChatHomeRepositoryImpl extends ChatHomeRepository {

  final ConversationService service;
  final SecureStorage secureStorage;

  ChatHomeRepositoryImpl({required this.service, required this.secureStorage});

  @override
  Future<List<ConversationEntity>> getConversations() async {
    try{
      var response =  await service.getConversations();
      var convos = response.data;
      for (var c in convos) {
        print("The last message time before: " + c.lastMessageTime.toString());
        c.lastMessageTime = c.lastMessageTime.toLocal();
        print("The last message time after: " + c.lastMessageTime.toString());
      }
      return convos;
    }
    catch(e) {
      print("Error in getting conversations: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<String> getSenderId() async{
    return await secureStorage.getUsername()?? "";
  }

}