part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//sign up
class SignedIn extends AuthState {
  final User? user;
  SignedIn(this.user);
}

//sign up and choose profile photo
class SignedInWithProfilePhoto extends AuthState {
  final User? user;
  SignedInWithProfilePhoto(this.user);
}

//login
class Login extends AuthState {
  final User? user;
  Login(this.user);
}

class SuggestedUsername extends AuthState {
  final List<String> usernames;
  SuggestedUsername(this.usernames);
}

class UserNameAvialable extends AuthState {
  final bool isAvailable;
  UserNameAvialable(this.isAvailable);
}
