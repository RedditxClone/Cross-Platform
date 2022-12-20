part of 'sort_cubit.dart';

@immutable
abstract class SortState {}

class SortInitial extends SortState {}

class SortHot extends SortState {}

class SortNew extends SortState {}

class SortBest extends SortState {}

class SortTop extends SortState {}
