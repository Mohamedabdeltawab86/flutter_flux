part of 'auth_bloc.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginLoading extends AuthState {}
final class LoginSuccess extends AuthState {
  final String email;
  final String name;
  final String photoUrl;

  LoginSuccess({required this.email, required this.name, required this.photoUrl});
}
final class LoginFailure extends AuthState {
  final String message;

  LoginFailure({required this.message});


}
