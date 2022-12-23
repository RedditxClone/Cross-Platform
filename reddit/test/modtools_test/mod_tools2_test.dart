import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';

class MockModToolsRepository extends Mock implements ModToolsRepository {}

void main() {
  late MockModToolsRepository mockModToolsRepository;
  late ModtoolsCubit modToolsCubit;
  final userList = [
    User(coverPhoto: ""),
  ];
  group("State test", () {
    setUp(() {
      mockModToolsRepository = MockModToolsRepository();
      modToolsCubit = ModtoolsCubit(mockModToolsRepository);
    });

    blocTest<ModtoolsCubit, ModtoolsState>(
      'ModeratorsListAvailable state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.getModerators('id')).thenAnswer(
          (_) async => userList,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getModerators('id'),
      expect: () => [isA<ModeratorsListAvailable>()],
    );

    blocTest<ModtoolsCubit, ModtoolsState>(
      'ModeratorsListAvailable state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.getMutedUsers('id')).thenAnswer(
          (_) async => userList,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getMutedUsers('id'),
      expect: () => [isA<MutedListAvailable>()],
    );

    blocTest<ModtoolsCubit, ModtoolsState>(
      'BannedListAvailable state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.getBannedUsers('id')).thenAnswer(
          (_) async => userList,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getBannedUsers('id'),
      expect: () => [isA<BannedListAvailable>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'AddedToModerators state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.addModerator('id', "user"))
            .thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.addModerator('id', "user"),
      expect: () => [isA<AddedToModerators>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'MuteUser state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.muteUser(
            "subredditId", "username", "muteReason")).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) =>
          cubit.muteUser("subredditId", "username", "muteReason"),
      expect: () => [isA<MuteUser>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'BanUser state is emitted correctly after getting data from the server',
      setUp: () {
        when(() => mockModToolsRepository.banUser("subredditId", "username",
            "banReason", 1, "modNote", "banMessage", false)).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.banUser("subredditId", "username",
          "banReason", 1, "modNote", "banMessage", false),
      expect: () => [isA<BanUser>()],
    );
  });
}
