import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_in.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  SignInBloc(this.signInUseCase) : super(SignInInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(SignInLoading());

      try {
        final tokenEntity = await signInUseCase.call(event.username, event.password);

        // Save the username in secure storage
        await storage.write(key: 'username', value: event.username);

        emit(SignInSuccess(tokenEntity.token));
      } catch (e) {
        emit(SignInFailure(e.toString()));
      }
    });
  }
}


