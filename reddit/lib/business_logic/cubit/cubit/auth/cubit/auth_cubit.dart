// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../../data/model/auth_model.dart';
import '../../../../../data/repository/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signupRepo) : super(AuthInitial());
  final AuthRepo signupRepo;

  /// This function emits state SignedIn after the user sign up.
  /// This function calls the function [AuthRepo.signup] which makes the request to the server.
  /// 
  /// [username]: The username of the user.
  /// [password]: The password of the user.
  /// [email]: The email of the user.
  void signup(String password, String username, String email) async {
    signupRepo.signup(password, username, email).then((value) {
      emit(SignedIn(value));
      debugPrint("after emitting signup ${value?.name}");
    });
  }

  /// This function emits state Login after the user login.
  /// This function calls the function [AuthRepo.login] which makes the request to the server.
  /// 
  /// [username]: The username of the user.
  /// [password]: The password of the user.
  void login(String password, String username) async {
    signupRepo.login(password, username).then((value) {
      emit(Login(value));
      debugPrint("after emitting login ${value?.name}");
    });
  }

  /// This function emits state SuggestedUsername in the initState of the signup_page2.
  /// This function calls the function [AuthRepo.getSuggestedUsernames] which makes the request to the server.
  void getSuggestedUsernames() async {
    signupRepo.getSuggestedUsernames().then((value) {
      emit(SuggestedUsername(value));
      debugPrint("after emitting suggested usernames ${value.toString()}");
    });
  }

  /// This function emits state UserNameAvialable after the user finished writing his username.
  /// This function calls the function [AuthRepo.checkOnUsername] which makes the request to the server.
  void checkOnUsername(String username) async {
    signupRepo.checkOnUsername(username).then((value) {
      emit(UserNameAvialable(value));
      debugPrint("after emitting username available $value");
    });
  }

  /// This function emits state SignedInWithProfilePhoto after the user choose his profile picture during signup.
  /// This function calls the function [AuthRepo.updateImageWeb] which makes the request to the server.
  void changeProfilephotoWeb(User? userWithPP, Uint8List fileAsBytes) {
    if (isClosed) return;
    signupRepo.updateImageWeb('profilephoto', fileAsBytes).then((image) {
      userWithPP?.profilePic = image as String?;
      debugPrint("image from cubit: $image");
      emit(SignedInWithProfilePhoto(userWithPP));
    });
  }
}
