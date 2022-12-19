part of 'search_people_cubit.dart';

@immutable
abstract class SearchPeopleState {}

class SearchPeopleInitial extends SearchPeopleState {}

class GetSearchPeople extends SearchPeopleState {
  final List<User> users;
  GetSearchPeople(this.users);
}

class FollowUser extends SearchPeopleState {
  final bool followed;
  FollowUser(this.followed);
}
