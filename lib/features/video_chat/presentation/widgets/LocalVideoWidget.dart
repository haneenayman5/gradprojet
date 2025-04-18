import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class LocalVideoWidget extends StatelessWidget {
  final RtcEngine engine;

  const LocalVideoWidget({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(
          uid: 0, // Local user's UID is typically 0.
          renderMode: RenderModeType.renderModeHidden,
        ),
      ),
    );
  }
}
