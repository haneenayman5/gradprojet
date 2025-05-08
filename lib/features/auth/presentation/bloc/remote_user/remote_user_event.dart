import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteUsersEvent extends Equatable{
  const RemoteUsersEvent();
}

class GetUsers extends RemoteUsersEvent{
  const GetUsers();

  @override
  List<Object?> get props => [];
}

class UpdatePfp extends RemoteUsersEvent {
  final MultipartFile img;

  const UpdatePfp({required this.img});

  @override
  List<Object?> get props => [img];

}