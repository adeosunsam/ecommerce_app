import 'package:bloc/bloc.dart';
import 'package:ecommerce_store/services/authservice/iauth_service.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(IAuthService service)
      : super(
          const AuthStateUninitialized(isLoading: true),
        ) {
    on<AuthEventLogin>(
      (event, emit) async {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while i log you in',
        ));
        try {
          final userToken = await service.logIn(
            email: event.email,
            password: event.password,
          );
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(AuthStateLoggedIn(
            isLoading: false,
            user: userToken,
          ));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );
    on<AuthEventGetUser>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
        ),
      );
      try {
        final user = await service.currentUser;
        if (user == null) {
          throw Exception();
        }
        emit(
          AuthStateLoggedUser(isLoading: false, user: user),
        );
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
  }
}
