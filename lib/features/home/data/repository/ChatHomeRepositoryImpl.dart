import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/home/data/data_source/ConversationService.dart';
import 'package:untitled3/features/home/domain/entity/ConversationEntity.dart';
import 'package:untitled3/features/home/domain/repository/ChatHomeRepository.dart';

class ChatHomeRepositoryImpl extends ChatHomeRepository {

  final ConversationService service;
  final SecureStorage secureStorage;

  ChatHomeRepositoryImpl({required this.service, required this.secureStorage});

  @override
  Future<List<ConversationEntity>> getConversations() async {
    try{
      var response =  await service.getConversations();
      return response.data;
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