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
    if (isClosed) return;
    authRepo.signup(password, username, email).then((value) {
      emit(SignedIn(value));
    });
  }

  /// [username] : The username of the user.
  /// [password] : The password of the user.
  ///
  /// This function emits state [Login] after the user login.
  /// This function calls the function [AuthRepo.login] which makes the request to the server.
  void login(String password, String username) async {
    if (isClosed) return;
    authRepo.login(password, username).then((value) {
      emit(Login(value));
    });
  }

  /// [googleToken] : The token of the user from google.
  ///
  /// This function emits state [Login] after the user login with google.
  /// This function calls the function [AuthRepo.loginWithGoogle] which makes the request to the server.
  void loginWithGoogle(String googleToken) async {
    if (isClosed) return;
    authRepo.loginWithGoogle(googleToken).then((value) {
      emit(Login(value));
      debugPrint("after emitting login ${value.toString()}");
    });
  }

  /// This function emits state [SuggestedUsername] in the initState of the signup_page2.
  /// This function calls the function [AuthRepo.getSuggestedUsernames] which makes the request to the server.
  void getSuggestedUsernames() async {
    if (isClosed) return;
    authRepo.getSuggestedUsernames().then((value) {
      emit(SuggestedUsername(value));
      debugPrint("after emitting suggested usernames ${value.toString()}");
    });
  }

  /// [username] : The username of the user.
  /// This function emits state [UserNameAvialable] after the user finished writing his username.
  ///
  /// This function calls the function [AuthRepo.checkOnUsername] which makes the request to the server.
  void checkOnUsername(String username) {
    if (isClosed) return;
    authRepo.checkOnUsername(username).then((value) {
      emit(UserNameAvialable(value));
      debugPrint("after emitting username available $value");
    });
  }

  /// [fileAsBytes] : [Uint8List] which is the image required to be uploaded.
  ///
  /// This function emits state [SignedInWithProfilePhoto] after the user choose his profile picture during signup.
  /// This function calls the function [AuthRepo.updateImageWeb] which makes the request to the server.
  void changeProfilephotoWeb(Uint8List fileAsBytes) {
    if (isClosed) return;
    authRepo
        .updateImageWeb('profilephoto', fileAsBytes, UserData.user!.token??"")
        .then((image) {
      debugPrint("image from cubit: $image");
      emit(SignedInWithProfilePhoto(image));
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
    if (isClosed) return;
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
    if (isClosed) return;
    authRepo.addInterests(selectedInterests, token).then((value) {
      emit(AddUserInterests(value));
    });
  }

  /// [username] : The username of the user.
  ///
  /// This function emits state [ForgetPassword] after the user click on forget password.
  /// This function calls the function [AuthRepo.forgetPassword] which makes the request to the server.
  void forgetPassword(String username) {
    if (isClosed) return;
    authRepo.forgetPassword(username).then((value) {
      emit(ForgetPassword(value));
    });
  }

  /// [email] : The email of the user.
  ///
  /// This function emits state [ForgetUsername] after the user click on forget username.
  /// This function calls the function [AuthRepo.forgetUsername] which makes the request to the server.
  void forgetUsername(String email) {
    if (isClosed) return;
    authRepo.forgetUsername(email).then((value) {
      emit(ForgetUsername(value));
    });
  }

  /// [token] : [String] which is The id of the user.
  ///
  /// This function makes the request to get the user data with the user Id.
  /// This function calls the function [AuthRepo.getUserData] which makes the request to the server.
  /// This function emits state [GetTheUserData] after the user login.
  void getUserData(String token) {
    if (isClosed) return;
    bool flag = UserData.isLogged();
    debugPrint("is logged in $flag");
    if (flag) {
      debugPrint("user is logged in");
      authRepo.getUserData(token).then((value) {
        emit(GetTheUserData(value));
      });
    } else {
      debugPrint("user is not logged in");
      emit(NotLoggedIn());
    }
  }
}
