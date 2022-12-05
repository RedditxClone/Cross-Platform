import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import '../../../../../data/model/auth_model.dart';
import '../../../../../data/repository/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, this.settingsRepository) : super(AuthInitial());
  final AuthRepo authRepo;
  final SettingsRepository settingsRepository;

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  /// [email] : The email of the user.
  ///
  /// This function emits state [SignedIn] after the user sign up.
  /// This function calls the function [AuthRepo.signup] which makes the request to the server.
  void signup(String password, String username, String email) async {
    authRepo.signup(password, username, email).then((value) {
      settingsRepository.settingsWebServices.token = value!.accessToken;
      emit(SignedIn(value));
      debugPrint("after emitting signup ${value.username}");
    });
  }

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  ///
  /// This function emits state [Login] after the user login.
  /// This function calls the function [AuthRepo.login] which makes the request to the server.
  void login(String password, String username) async {
    authRepo.login(password, username).then((value) {
      emit(Login(value));
      debugPrint("after emitting login ${value?.username}");
    });
  }

  /// This function emits state [SuggestedUsername] in the initState of the signup_page2.
  /// This function calls the function [AuthRepo.getSuggestedUsernames] which makes the request to the server.
  void getSuggestedUsernames() async {
    authRepo.getSuggestedUsernames().then((value) {
      emit(SuggestedUsername(value));
      debugPrint("after emitting suggested usernames ${value.toString()}");
    });
  }

  /// [username] : The username of the user.
  /// This function emits state [UserNameAvialable] after the user finished writing his username.
  ///
  /// This function calls the function [AuthRepo.checkOnUsername] which makes the request to the server.
  void checkOnUsername(String username) async {
    authRepo.checkOnUsername(username).then((value) {
      emit(UserNameAvialable(value));
      debugPrint("after emitting username available $value");
    });
  }

  /// [fileAsBytes] : [Uint8List] which is the image required to be uploaded.
  /// [userWithPP] : [User] which is an object of the user.
  ///
  /// This function emits state [SignedInWithProfilePhoto] after the user choose his profile picture during signup.
  /// This function calls the function [AuthRepo.updateImageWeb] which makes the request to the server.
  void changeProfilephotoWeb(User? userWithPP, Uint8List fileAsBytes) {
    if (isClosed) return;
    authRepo
        .updateImageWeb('profilephoto', fileAsBytes, userWithPP!.accessToken)
        .then((image) {
      userWithPP.profilePic = image as String;
      debugPrint("image from cubit: $image");
      emit(SignedInWithProfilePhoto(userWithPP));
    });
  }

  void changeProfilephotoMob(File img) {
    if (isClosed) return;
    settingsRepository.updateImage('profilephoto', img).then((image) {
      emit(ChooseProfileImageLoginChanged(image));
    });
  }

  /// [token] : [String] which is The token of the user.
  /// [gender] : [String] the gender selected by the user
  ///
  /// This function makes the request to udate the user gender during signup.
  /// This function calls the function [AuthRepo.genderInSignup] which makes the request to the server.
  /// This function emits state [UpdateGenderDuringSignup] after the
  void genderInSignup(String token, String gender) {
    authRepo.genderInSignup(gender, token).then((value) {
      emit(UpdateGenderDuringSignup(value));
    });
  }
  /// [selectedInterests] : [Map] which is the list of the interests selected by the user.
  /// [token] : [String] which is The token of the user.
  ///
  /// This function makes the request to update the user interests during signup.
  /// This function calls the function [AuthRepo.addInterests] which makes the request to the server.
  /// This function emits state [AddUserInterests] after the user choose his interests during signup.
  void addInterests(Map<String, dynamic> selectedInterests, String token) {
    authRepo.addInterests(selectedInterests, token).then((value) {
      emit(AddUserInterests(value));
    });
  }
}
