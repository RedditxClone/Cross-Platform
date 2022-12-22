part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//sign up
class SignedIn extends AuthState {
  final Map<String, dynamic> userDataJson;
  SignedIn(this.userDataJson);
}

//sign up and choose profile photo
class SignedInWithProfilePhoto extends AuthState {
  final String imgUrl;
  SignedInWithProfilePhoto(this.imgUrl);
}

//login
class Login extends AuthState {
  final Map<String, dynamic> userDataJson;
  Login(this.userDataJson);
}

class SuggestedUsername extends AuthState {
  final List<String> usernames;
  SuggestedUsername(this.usernames);
}

class UserNameAvialable extends AuthState {
  final bool isAvailable;
  UserNameAvialable(this.isAvailable);
}

class ChooseProfileImageLoginChanged extends AuthState {
  final String url;
  ChooseProfileImageLoginChanged(this.url);
}

class AddUserInterests extends AuthState {
  final bool interestsUpdated;
  AddUserInterests(this.interestsUpdated);
}

class UpdateGenderDuringSignup extends AuthState {
  final bool genderUpdated;
  UpdateGenderDuringSignup(this.genderUpdated);
}

class ForgetPassword extends AuthState {
  final bool isSent;
  ForgetPassword(this.isSent);
}

class ForgetUsername extends AuthState {
  final bool isSent;
  ForgetUsername(this.isSent);
}

class GetTheUserData extends AuthState {
  final Map<String, dynamic> userDataJson;
  GetTheUserData(this.userDataJson);
}

class NotLoggedIn extends AuthState {}