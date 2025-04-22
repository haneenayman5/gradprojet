import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:go_router/go_router.dart';

// Import your bloc, events, and states
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_bloc.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_events.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_states.dart';


import '../../../../core/util/app_route.dart';
import '../widgets/LocalVideoWidget.dart';
import '../widgets/RemoteVideoWidget.dart';

import '../../domain/utils/channel_name_generator.dart';

class VideoChatTestPage extends StatefulWidget {
  final String username1;
  final String username2;

  const VideoChatTestPage({super.key, required this.username1, required this.username2});

  @override
  _VideoChatTestPageState createState() => _VideoChatTestPageState();
}

class _VideoChatTestPageState extends State<VideoChatTestPage> {
  // Optionally, store any local state if necessary

  @override
  void initState() {
    super.initState();
    context.read<VideoChatBloc>().add(VideoChatConnectionRequested(
      channelName: ChannelNameGenerator.makeChannelName(widget.username1, widget.username2),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    print("disposeddddddddddddd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Chat Test")),
      body: BlocConsumer<VideoChatBloc, VideoChatState>(
        listener: (context, state) {
          if (state is VideoChatConnectionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Connection Failed: ${state.exception.toString()}")),
            );
          } else  if (state is VideoChatDisconnected) {
            GoRouter.of(context).pushReplacement(AppRoute.homePath);
          }
        },
        builder: (context, state) {
          print("the state issssssssssssssssssss: $state");
          if (state is VideoChatInitial) {
            return const Center(child: Text("Initializing..."));
          }
          if (state is VideoChatConnecting) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoChatShowRemoteUser) {
            // Assumes state contains the Agora engine instance, the remote user ID, and channel name.
            final RtcEngine agoraEngine = state.engine;
            final int? remoteUid = state.remoteUid;
            final String channelName = ChannelNameGenerator.makeChannelName(widget.username1, widget.username2);
            return Column(
              children: [
                // Display local and remote video views.
                Expanded(
                  child: Stack(
                    children: [
                      // Remote video: if a remote user has joined, show their video; otherwise, show waiting text.
                      RemoteVideoWidget(
                        engine: agoraEngine,
                        remoteUid: remoteUid, // This might be null if no remote user has joined.
                        channel: channelName,
                      ),
                      // Local video: positioned in the corner.
                      Positioned(
                        top: 16,
                        right: 16,
                        width: 120,
                        height: 160,
                        child: LocalVideoWidget(
                          engine: agoraEngine,
                        ),
                      ),
                    ],
                  ),
                ),
                // A button to end the call.
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                       context.read<VideoChatBloc>().add(VideoChatDisconnectRequested());
                    },
                    child: const Text("End Call"),
                  ),
                ),
              ],
            );
          }else if(state is VideoChatConnected) {
            final RtcEngine agoraEngine = state.engine;
            return Column(
              children: [
                // Display local and remote video views.
                Expanded(
                  child: Stack(
                    children: [
                      // Local video: positioned in the corner.
                      Positioned(
                        top: 16,
                        right: 16,
                        width: 120,
                        height: 160,
                        child: LocalVideoWidget(
                          engine: agoraEngine,
                        ),
                      ),
                    ],
                  ),
                ),
                // A button to end the call.
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<VideoChatBloc>().add(VideoChatDisconnectRequested());
                    },
                    child: const Text("End Call"),
                  ),
                ),
              ],
            );
          } else if (state is VideoChatConnectionFailed) {
            return Center(child: Text("Error: ${state.exception.toString()}"));
          } else if (state is VideoChatRemoteUserLeft) {
            return const Center(
              child: Text(
                "No one is here, yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return const Center(child: Text("Initializing...klasdfbnasdfbhjklasdfhjklsdfajkhlsdfahjkl;sdfahjkl;asdfhjkl "));
        },
      ),
    );
  }
}
