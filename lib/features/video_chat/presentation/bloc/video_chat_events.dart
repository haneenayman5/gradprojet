import 'package:equatable/equatable.dart';

abstract class VideoChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoChatConnectionRequested extends VideoChatEvent {
  final String channelName;

  VideoChatConnectionRequested({required this.channelName});

  @override
  List<Object?> get props => [channelName];
}

class VideoChatDisconnectRequested extends VideoChatEvent {}

class VideoChatRemoteUserJoined extends VideoChatEvent {
  final int remoteUid;

  VideoChatRemoteUserJoined({required this.remoteUid});

  @override
  List<Object?> get props => [remoteUid];
}

class VideoChatRemoteUserDisconnected extends VideoChatEvent {}
