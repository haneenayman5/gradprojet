import 'dart:async';

import 'package:untitled3/features/video_chat/data/data_sources/AgoraService.dart';
import 'package:untitled3/features/video_chat/domain/repository/VideoChatRepository.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraVideoChatRepository implements VideoChatRepository {
  late final RtcEngine _engine;
  final _remoteUserStreamController = StreamController<int?>.broadcast();
  final _localUserStreamController = StreamController<int?>.broadcast();
  final AgoraService agoraService;

  AgoraVideoChatRepository({required this.agoraService});

  @override
  Stream<int?> get remoteUserStream => _remoteUserStreamController.stream;

  @override
  Stream<int?> get localUserStream => _localUserStreamController.stream;

  @override
  Future<RtcEngine> initializeSDK() async{
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "550b081e687947dd9d793b39b7683759",
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    return _engine;
  }

  @override
  Future<void> joinChannel(String channel, int   uid) async{
    String token = await getChatToken(channel);
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true, // Automatically subscribe to all video streams
        autoSubscribeAudio: true, // Automatically subscribe to all audio streams
        publishCameraTrack: true, // Publish camera-captured video
        publishMicrophoneTrack: true, // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: uid,
    );
  }

  @override
  void setupEventHandlers(){
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          _localUserStreamController.add(connection.localUid);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          _remoteUserStreamController.add(remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          _remoteUserStreamController.add(null);
        },
      ),
    );
  }

  @override
  Future<void> setupLocalVideo() async{
    // The video module and preview are disabled by default.
    await _engine.enableVideo();
    await _engine.startPreview();
  }

  @override
  Future<void> cleanupEngine() async{
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Future<void> requestPermissions() async{
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  Future<String> getChatToken(String channelName) async {
    var response = await agoraService.getToken(channelName);
    return response.token;
  }


  
}