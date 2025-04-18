import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetLocalUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetRemoteUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/connectToVideoChat.dart';
import 'package:untitled3/features/video_chat/domain/usecases/disconnectFromVideoChat.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_events.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_states.dart';

class VideoChatBloc extends Bloc<VideoChatEvent, VideoChatState> {
  final ConnectToVideoChatUsecase connectUsecase;
  final DisconnectFromVideoChatUsecase disconnectUsecase;
  final GetLocalUserStreamUsecase getLocalUserStreamUsecase;
  final GetRemoteUserStreamUsecase getRemoteUserStreamUsecase;

  RtcEngine? engine;

  VideoChatBloc({required this.getRemoteUserStreamUsecase, required this.getLocalUserStreamUsecase, required this.connectUsecase, required this.disconnectUsecase}): super(VideoChatInitial()) {
    on<VideoChatConnectionRequested>((event, emit) async {
      print("connection requested");
      emit(VideoChatConnecting());

      try {
        engine ??= await connectUsecase.call(event.channelName, 0);
        await getLocalUserStreamUsecase.call().first;
        emit(VideoChatConnected(engine: engine!));
      }
      catch(e) {
        print(e.toString());
        emit(VideoChatConnectionFailed(exception: e as Exception));
      }
    });

    on<VideoChatDisconnectRequested>((event, emit) async {
      try {
        await disconnectUsecase.call();
        emit(VideoChatDisconnected());
      }
      catch(e) {
        print(e.toString());
      }
    });

    on<VideoChatRemoteUserJoined>((event, emit) async {
      emit(VideoChatShowRemoteUser(remoteUid: event.remoteUid, engine: engine!));
    });

    getRemoteUserStreamUsecase.call().listen((data) {
      add(VideoChatRemoteUserJoined(remoteUid: data!));
    });
  }
}