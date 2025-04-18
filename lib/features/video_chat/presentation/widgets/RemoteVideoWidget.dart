import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class RemoteVideoWidget extends StatelessWidget {
  final RtcEngine engine;
  final int? remoteUid; // The UID of the remote user (or null if not joined)
  final String channel;

  const RemoteVideoWidget({
    super.key,
    required this.engine,
    required this.remoteUid,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    // If a remote user has joined (remoteUid is not null),
    // display their video stream; otherwise, show a waiting message.
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(
            uid: remoteUid!, // the remote user's UID
            renderMode: RenderModeType.renderModeHidden,
          ),
          connection: RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Waiting for remote user to join...',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
