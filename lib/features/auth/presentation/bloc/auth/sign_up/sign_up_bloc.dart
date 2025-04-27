import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_up.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignUpLoading());

      try {
        await signUpUseCase.call(
          event.username,
          event.password,
          event.firstName,
          event.lastName,
          event.dateOfBirth,
          event.email,
        );
        emit(SignUpSuccess());
      } on DioException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';

        if (e.response != null && e.response?.statusCode == 400) {
          final data = e.response?.data;

          if (data is Map<String, dynamic>) {
            if (data.containsKey('message')) {
              errorMessage = data['message'];
            } else if (data.containsKey('error')) {
              errorMessage = data['error'];
            }
          } else if (data.toString().contains('already exists')) {
            errorMessage = 'An account with this email or username already exists.';
          }
        }

        emit(SignUpFailure(errorMessage));
      } catch (e) {
        emit(SignUpFailure('Unexpected error occurred.'));
      }
    });
  }
}
