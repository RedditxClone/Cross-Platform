import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/user_profile/follow_unfollow_cubit.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';
import 'package:reddit/data/web_services/user_profile/user_profile_webservices.dart';

class MockProfileWebService extends Mock implements UserProfileWebServices {}

class MockFollowUnfollowCubit extends MockCubit<FollowUnfollowState>
    implements FollowUnfollowCubit {}

void main() async {
  late MockProfileWebService mockProfileWebService;
  late UserProfileRepository profileRepository;

  late FollowUnfollowCubit followUnfollowCubit;
  group("State test", () {
    setUp(() {
      mockProfileWebService = MockProfileWebService();
      profileRepository = UserProfileRepository(mockProfileWebService);
      followUnfollowCubit = FollowUnfollowCubit(profileRepository);
    });

    blocTest<FollowUnfollowCubit, FollowUnfollowState>(
      'FollowOtherUserSuccess state is emitted correctly on successfully following the user and get status code 201 from server',
      setUp: () {
        when(() => mockProfileWebService.follow('userID')).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return followUnfollowCubit;
      },
      act: (FollowUnfollowCubit cubit) => cubit.follow('userID'),
      expect: () => [isA<FollowOtherUserSuccess>()],
    );
    blocTest<FollowUnfollowCubit, FollowUnfollowState>(
      'FollowOtherUserNotSuccess state is emitted correctly on failing to follow the user and get status code 400 from server',
      setUp: () {
        when(() => mockProfileWebService.follow('userID')).thenAnswer(
          (_) async => 400,
        );
      },
      build: () {
        return followUnfollowCubit;
      },
      act: (FollowUnfollowCubit cubit) => cubit.follow('userID'),
      expect: () => [isA<FollowOtherUserNotSuccess>()],
    );
    blocTest<FollowUnfollowCubit, FollowUnfollowState>(
      'UnFollowOtherUserSuccess state is emitted correctly on successfully unfollowing the user and get status code 201 from server',
      setUp: () {
        when(() => mockProfileWebService.unfollow('userID')).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return followUnfollowCubit;
      },
      act: (FollowUnfollowCubit cubit) => cubit.unfollow('userID'),
      expect: () => [isA<UnFollowOtherUserSuccess>()],
    );
    blocTest<FollowUnfollowCubit, FollowUnfollowState>(
      'UnFollowOtherUserNotSuccess state is emitted correctly on failing to unfollow the user and get status code 400 from server',
      setUp: () {
        when(() => mockProfileWebService.unfollow('userID')).thenAnswer(
          (_) async => 400,
        );
      },
      build: () {
        return followUnfollowCubit;
      },
      act: (FollowUnfollowCubit cubit) => cubit.unfollow('userID'),
      expect: () => [isA<UnFollowOtherUserNotSuccess>()],
    );
  });
}
