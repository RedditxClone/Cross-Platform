part of 'block_cubit.dart';

@immutable
abstract class BlockState {}

class BlockInitial extends BlockState {}

class UserBlockedSuccessfully extends BlockState {}

class Error extends BlockState {}
