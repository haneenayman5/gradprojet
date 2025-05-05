import 'package:flutter/cupertino.dart';

@immutable
abstract class SoundMonitorState {}

class SoundMonitorInitial extends SoundMonitorState {}

class SoundMonitorRunning extends SoundMonitorState {
  final double dbLevel;
  final List<String> soundEvents;
  SoundMonitorRunning({required this.soundEvents, required this.dbLevel});
}

class SoundMonitorError extends SoundMonitorState {
  final String message;
  SoundMonitorError({required this.message});
}