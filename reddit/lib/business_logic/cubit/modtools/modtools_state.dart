part of 'modtools_cubit.dart';

@immutable
abstract class ModtoolsState {}

class ModtoolsInitial extends ModtoolsState {}

class ApprovedListAvailable extends ModtoolsState {
  List<User> approved;
  ApprovedListAvailable(this.approved);
}

class AddedToApprovedUsers extends ModtoolsState {
  List<User> approved;
  AddedToApprovedUsers(this.approved);
}

class RemovedFromApprovedUsers extends ModtoolsState {
  List<User> approved;
  RemovedFromApprovedUsers(this.approved);
}
