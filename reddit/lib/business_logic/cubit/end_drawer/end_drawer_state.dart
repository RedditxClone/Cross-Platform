part of 'end_drawer_cubit.dart';

@immutable
abstract class EndDrawerState {}

class EndDrawerInitial extends EndDrawerState {}

/// Emitted when profile picture is changed successfully from end drawer.
class EndDrawerProfilePictureChanged extends EndDrawerState {
  String url;
  EndDrawerProfilePictureChanged(this.url);
}
