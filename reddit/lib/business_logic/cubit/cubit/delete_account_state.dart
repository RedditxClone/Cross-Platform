part of 'delete_account_cubit.dart';

@immutable
abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class AccountDeleted extends DeleteAccountState {}

class AccountDeleteError extends DeleteAccountState {
  int statusCode;
  AccountDeleteError(this.statusCode);
}
