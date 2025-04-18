import 'package:untitled3/features/video_chat/domain/repository/VideoChatRepository.dart';

class DisconnectFromVideoChatUsecase {
  final VideoChatRepository videoChatRepository;

  DisconnectFromVideoChatUsecase({required this.videoChatRepository});

  Future<void> call() async{
    await videoChatRepository.cleanupEngine();
  }
}