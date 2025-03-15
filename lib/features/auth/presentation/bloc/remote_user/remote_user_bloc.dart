import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/core/resources/data_state.dart';
import 'package:untitled3/features/auth/domain/usecases/get_users.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_event.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_state.dart';

class RemoteUsersBloc extends Bloc<RemoteUsersEvent, RemoteUsersState>{

  final GetUsersUseCase _getUsersUseCase;

  RemoteUsersBloc(this._getUsersUseCase) : super(const RemoteUsersLoading()){
    on <GetUsers> (onGetUsers);
  }

  void onGetUsers(GetUsers event, Emitter<RemoteUsersState> emit) async
  {
    final dataState = await _getUsersUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty)
    {
      emit(RemoteUsersDone(dataState.data!));
    }

    if(dataState is DataFailed)
    {
      emit(RemoteUsersError(dataState.exception!));
    }
  }
}