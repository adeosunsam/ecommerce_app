import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final User? user;
  const AuthStateLoggedIn({
    required bool isLoading,
    required this.user,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedUser extends AuthState {
  final UserData user;
  const AuthStateLoggedUser({
    required bool isLoading,
    required this.user,
  }) : super(isLoading: isLoading);
}

class GetDataStateFailed extends AuthState {
  final Exception? exception;
  const GetDataStateFailed({
    required this.exception,
  }) : super(isLoading: false);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );
  @override
  List<Object?> get props => [exception, isLoading];
}
