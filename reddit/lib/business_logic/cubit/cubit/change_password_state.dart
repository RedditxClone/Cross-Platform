part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

/// User entered a wrong password old password when changing his password.
class WrongPassword extends ChangePasswordState {}

/// Password is updated successfully
class PasswordUpdatedSuccessfully extends ChangePasswordState {}
