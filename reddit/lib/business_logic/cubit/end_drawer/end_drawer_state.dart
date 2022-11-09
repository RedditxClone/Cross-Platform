part of 'end_drawer_cubit.dart';

@immutable
abstract class EndDrawerState {}

class EndDrawerInitial extends EndDrawerState {}

class EndDrawerProfilePictureChanged extends EndDrawerState {
  String url;
  EndDrawerProfilePictureChanged(this.url);
}
