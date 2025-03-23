import 'package:untitled3/features/home/domain/repository/ChatHomeRepository.dart';

class GetSenderIdUseCase {
  final ChatHomeRepository chatHomeRepository;

  GetSenderIdUseCase({required this.chatHomeRepository});

  Future<String> call() async {
    return await chatHomeRepository.getSenderId();
}
}