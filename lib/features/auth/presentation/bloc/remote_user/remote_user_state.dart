import 'package:dio/dio.dart';
import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';

abstract class RemoteUsersState {
  final List<UserEntity> ? users;
  final DioException ? error;

  const RemoteUsersState({this.users,this.error});
}

class RemoteUsersLoading extends RemoteUsersState {
  const RemoteUsersLoading();
}

class RemoteUsersDone extends RemoteUsersState {
  const RemoteUsersDone(List<UserEntity> users) : super(users: users);
}

class RemoteUsersError extends RemoteUsersState {
  const RemoteUsersError(DioException e) : super(error: e);
}
