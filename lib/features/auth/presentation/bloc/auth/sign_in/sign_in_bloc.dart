import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_in.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc(this.signInUseCase) : super(SignInInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(SignInLoading());

      try{
        final token = await signInUseCase.call(event.username, event.password);
        emit(SignInSuccess(token.token));
        print("Token:::::    " + token.token);
      } catch (e) {
        emit(SignInFailure(e.toString()));
        print(e.toString());
      }
    });
  }
}