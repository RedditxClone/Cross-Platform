part of 'save_cubit.dart';

@immutable
abstract class SaveState {}

class SaveInitial extends SaveState {}

class Saved extends SaveState {}

class Unsaved extends SaveState {}

class SaveError extends SaveState {
  int statusCode;
  SaveError(this.statusCode);
}

class UnsaveError extends SaveState {
  int statusCode;
  UnsaveError(this.statusCode);
}
