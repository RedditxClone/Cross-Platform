part of 'choose_profile_image_login_cubit.dart';

@immutable
abstract class ChooseProfileImageLoginState {}

class ChooseProfileImageLoginInitial extends ChooseProfileImageLoginState {}

class ChooseProfileImageLoginChanged extends ChooseProfileImageLoginState {
  String url;
  ChooseProfileImageLoginChanged(this.url);
}
