// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/signin.dart';
import '../../../../../data/repository/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signupRepo) : super(AuthInitial());
  final AuthRepo signupRepo;
  User? user;
  List<String> randomUsernames = [];
  bool isUsernameAvailable = false;
  Future<User?> signup(String password, String username, String email) async {
    signupRepo.signup(password, username, email).then((value) {
      user = value;
      emit(SignedIn(user));
      debugPrint("after emitting signup ${user?.name}");
    });
    return user;
  }

  Future<User?> login(String password, String username) async {
    signupRepo.login(password, username).then((value) {
      user = value;
      emit(Login(user));
      debugPrint("after emitting login ${user?.name}");
    });
    return user;
  }

  Future<List<String>> getSuggestedUsernames() async {
    signupRepo.getSuggestedUsernames().then((value) {
      randomUsernames = value;
      emit(SuggestedUsername(randomUsernames));
      debugPrint("after emitting suggested usernames ${randomUsernames}");
    });
    return randomUsernames;
  }

  Future<bool> checkOnUsername(String username) async {
    signupRepo.checkOnUsername(username).then((value) {
      isUsernameAvailable = value;
      emit(UserNameAvialable(value));
      debugPrint("after emitting username available $value");
    });
    return isUsernameAvailable;
  }

  /// change the profile photo from web: send to the backend the new image
  void changeProfilephotoWeb(User? userWithPP, Uint8List fileAsBytes) {
    if (isClosed) return;
    signupRepo.updateImageWeb('profilephoto', fileAsBytes).then((image) {
      userWithPP?.imageUrl = image as String?;
      debugPrint("image from cubit: $image");
      emit(SignedInWithProfilePhoto(userWithPP));
    });
  }
}
