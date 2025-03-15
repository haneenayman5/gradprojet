import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_up.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()){

    on<SignUpRequested>((event, emit) async {
      emit(SignUpLoading());

      try{
        await signUpUseCase.call(event.username, event.password, event.firstName, event.lastName, event.dateOfBirth, event.email);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
        print(e.toString());
      }
    });
  }
}