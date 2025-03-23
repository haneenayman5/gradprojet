import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/home/data/model/ConversationModel.dart';

part 'ConversationService.g.dart';

@RestApi(baseUrl: apiBaseURL)
abstract class ConversationService {
  factory ConversationService(Dio dio) = _ConversationService;

  @GET("/Conversation/Conversations")
  Future<HttpResponse<List<ConversationModel>>> getConversations();
}