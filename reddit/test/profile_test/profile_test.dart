import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';
import 'package:reddit/data/web_services/user_profile/user_profile_webservices.dart';

class MockProfileWebService extends Mock implements UserProfileWebServices {}

class MockProfileCubit extends MockCubit<UserProfileState>
    implements UserProfileCubit {}

void main() async {
  late MockProfileWebService mockProfileWebService;
  late UserProfileRepository profileRepository;

  late UserProfileCubit userProfileCubit;
  Map<String, dynamic> userinfoFromWebServices;
  List<Map<String, dynamic>> moderatingSubredditsFromWebServices;
  userinfoFromWebServices = {
    "_id": "",
    "profilePhoto": "",
    "coverPhoto": "",
    "username": "",
    "createdAt": "",
    "isBlocked": false,
    "isFollowed": false,
    "nsfw": false,
    "about": "",
    "displayName": "",
    "socialLinks": []
  };
  moderatingSubredditsFromWebServices = [
    {
      "_id": "",
      "name": "",
      "over18": false,
      "flairList": [],
      "categories": [],
      "createdDate": "",
      "users": 0,
      "joined": true
    },
  ];
  group("State test", () {
    setUp(() {
      mockProfileWebService = MockProfileWebService();
      profileRepository = UserProfileRepository(mockProfileWebService);
      userProfileCubit = UserProfileCubit(profileRepository);
      userinfoFromWebServices = {
        "_id": "",
        "profilePhoto": "",
        "coverPhoto": "",
        "username": "",
        "createdAt": "",
        "isBlocked": false,
        "isFollowed": false,
        "nsfw": false,
        "about": "",
        "displayName": "",
        "socialLinks": []
      };
    });

    blocTest<UserProfileCubit, UserProfileState>(
      'UserInfoAvailable state is emitted correctly after getting user info correctly from server',
      setUp: () {
        when(() => mockProfileWebService.getUserInfo('userID')).thenAnswer(
          (_) async => userinfoFromWebServices,
        );
      },
      build: () {
        return userProfileCubit;
      },
      act: (UserProfileCubit cubit) => cubit.getUserInfo('userID'),
      expect: () => [isA<UserInfoAvailable>()],
    );
    blocTest<UserProfileCubit, UserProfileState>(
      'MyModSubredditsAvailable state is emitted correctly after getting user\'s moderting subreddits correctly from server',
      setUp: () {
        when(() => mockProfileWebService.getMyModeratedSubreddits()).thenAnswer(
          (_) async => moderatingSubredditsFromWebServices,
        );
      },
      build: () {
        return userProfileCubit;
      },
      act: (UserProfileCubit cubit) => cubit.getMyModeratedSubreddits(),
      expect: () => [isA<MyModSubredditsAvailable>()],
    );
    blocTest<UserProfileCubit, UserProfileState>(
      'MyModSubredditsAvailable state is emitted correctly after leaving a moderating subreddit from server',
      setUp: () {
        when(() => mockProfileWebService.leaveSubreddit('subredditID'))
            .thenAnswer(
          (_) async => 201,
        );
        when(() => mockProfileWebService.getMyModeratedSubreddits()).thenAnswer(
          (_) async => moderatingSubredditsFromWebServices,
        );
      },
      build: () {
        return userProfileCubit;
      },
      act: (UserProfileCubit cubit) => cubit.leaveSubreddit('subredditID'),
      expect: () => [isA<MyModSubredditsAvailable>()],
    );
    blocTest<UserProfileCubit, UserProfileState>(
      'UserBlocked state is emitted correctly after blocking a user from his profile from server',
      setUp: () {
        when(() => mockProfileWebService.blockUser('username')).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return userProfileCubit;
      },
      act: (UserProfileCubit cubit) => cubit.blockUser('username'),
      expect: () => [isA<UserBlocked>()],
    );
    blocTest<UserProfileCubit, UserProfileState>(
      'ErrorOccured state is emitted correctly after failing to block a user from his profile and get status code 400 from server',
      setUp: () {
        when(() => mockProfileWebService.blockUser('username')).thenAnswer(
          (_) async => 400,
        );
      },
      build: () {
        return userProfileCubit;
      },
      act: (UserProfileCubit cubit) => cubit.blockUser('username'),
      expect: () => [isA<ErrorOccured>()],
    );
  });
}
