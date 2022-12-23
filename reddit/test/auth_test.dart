import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/auth_repo.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/authorization/auth_web_service.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  // late MockAuthWebService mockAuthWebService;
  late MockAuthRepo mockAuthRepo;
  late AuthCubit authCubit;
  const json = {
    "token": "",
    "_id": "",
    "username": "",
    "email": "",
    "authType": "user",
    "profilePhoto": "",
    "coverPhoto": "",
    "displayName": "",
    "about": "",
    "cakeDay": true,
    "allowFollow": true,
    "createdAt": "2022-12-23T17:39:13.785Z"
  };
  const usernamesList = ["peter", "paul", "mary"];

  final authModelTest = User(
    type: "user",
    userId: "",
    username: "",
    email: "",
    profilePic: "",
    token: "",
    displayName: "",
    cakeDay: true,
    about: "",
    allowFollow: true,
    coverPhoto: "",
    createdAt: "2022-12-23T17:39:13.785Z",
  );

  // var postsFromRepository = <PostsModel>[];
  // postsFromRepository.add(postsModelTest);
  late Uint8List fileAsBytes;
  group("Auth state test", () {
    setUp(() {
      // mockAuthWebService = MockAuthWebService();
      fileAsBytes = Uint8List(10);
      mockAuthRepo = MockAuthRepo();
      authCubit =
          AuthCubit(mockAuthRepo, SettingsRepository(SettingsWebServices()));
    });

    blocTest<AuthCubit, AuthState>(
      'Login State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.login("password", "username")).thenAnswer(
          (_) async => json,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.login("password", "username"),
      expect: () => [isA<Login>()],
    );

    blocTest<AuthCubit, AuthState>(
      'SignedIn State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.signup("password", "username", "email"))
            .thenAnswer(
          (_) async => json,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.signup("password", "username", "email"),
      expect: () => [isA<SignedIn>()],
    );

    blocTest<AuthCubit, AuthState>(
      'Login State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.loginWithGoogle("token")).thenAnswer(
          (_) async => json,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.loginWithGoogle("token"),
      expect: () => [isA<Login>()],
    );

    blocTest<AuthCubit, AuthState>(
      'Login State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.loginWithGithub("token")).thenAnswer(
          (_) async => json,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.loginWithGithub("token"),
      expect: () => [isA<Login>()],
    );

    blocTest<AuthCubit, AuthState>(
      'SuggestedUsername State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.getSuggestedUsernames()).thenAnswer(
          (_) async => usernamesList,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.getSuggestedUsernames(),
      expect: () => [isA<SuggestedUsername>()],
    );

    blocTest<AuthCubit, AuthState>(
      'UserNameAvialable State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.checkOnUsername("peter")).thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.checkOnUsername("peter"),
      expect: () => [isA<UserNameAvialable>()],
    );
    blocTest<AuthCubit, AuthState>(
      'SignedInWithProfilePhoto State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.updateImageWeb('profile', fileAsBytes))
            .thenAnswer(
          (_) async => "imageURl",
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.changeProfilephotoWeb(fileAsBytes),
      expect: () => [isA<SignedInWithProfilePhoto>()],
    );
    blocTest<AuthCubit, AuthState>(
      'UpdateGenderDuringSignup State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.genderInSignup("token","male"))
            .thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.genderInSignup("token","male"),
      expect: () => [isA<UpdateGenderDuringSignup>()],
    );
    blocTest<AuthCubit, AuthState>(
      'ForgetPassword State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.forgetPassword("username"))
            .thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.forgetPassword("username"),
      expect: () => [isA<ForgetPassword>()],
    );
    blocTest<AuthCubit, AuthState>(
      'ForgetUsername State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.forgetUsername("email"))
            .thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.forgetUsername("email"),
      expect: () => [isA<ForgetUsername>()],
    );
    blocTest<AuthCubit, AuthState>(
      'AddUserInterests State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.addInterests({},"token"))
            .thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.addInterests({},"token"),
      expect: () => [isA<AddUserInterests>()],
    );
  
    blocTest<AuthCubit, AuthState>(
      'GetTheUserData State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockAuthRepo.getUserData("token"))
            .thenAnswer(
          (_) async => json,
        );
      },
      build: () {
        return authCubit;
      },
      act: (AuthCubit cubit) => cubit.getUserData("token"),
      expect: () => [isA<GetTheUserData>(),isA<NotLoggedIn>()],
    );
  });

  User modelFromJson;
  // Test if mapping from Json to model is correct
  group('User model test', () {
    test('User Model is generated correctly', () {
      modelFromJson = User.fromJson(json);
      expect(modelFromJson.userId, authModelTest.userId);
      expect(modelFromJson.username, authModelTest.username);
      expect(modelFromJson.token, authModelTest.token);
      expect(modelFromJson.email, authModelTest.email);
      expect(modelFromJson.type, authModelTest.type);
      expect(modelFromJson.profilePic, authModelTest.profilePic);
      expect(modelFromJson.displayName, authModelTest.displayName);
      expect(modelFromJson.about, authModelTest.about);
      expect(modelFromJson.cakeDay, authModelTest.cakeDay);
      expect(modelFromJson.allowFollow, authModelTest.allowFollow);
      expect(modelFromJson.coverPhoto, authModelTest.coverPhoto);
      expect(modelFromJson.createdAt, authModelTest.createdAt);
    });
  });
}
