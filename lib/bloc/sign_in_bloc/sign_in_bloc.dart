import 'package:booker/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:booker/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:booker/service/sign_in_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInAuthService authService;

  SignInBloc(this.authService) : super(SignInInitState()) {
    on<SubmitSignInEvent>((event, emit) async {
      emit(SignInLoadingState());
      try {
        String result = await authService.signIn(event.user);

        if (result == "User logged in successfully") {
          emit(SignInSuccessState(message: result));
        } else {
          emit(SignInErrorState(error: result));
        }
      } catch (e) {
        emit(SignInErrorState(error: "Unexpected error: $e"));
      }
    });
  }
}
