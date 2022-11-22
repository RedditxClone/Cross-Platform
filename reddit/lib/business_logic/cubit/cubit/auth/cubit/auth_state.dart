part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class SignedIn extends AuthState {
  final User? user;
  SignedIn(this.user);
}
  
