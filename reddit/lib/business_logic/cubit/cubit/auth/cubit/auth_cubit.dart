// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../../data/model/signin.dart';
import '../../../../../data/repository/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signupRepo) : super(AuthInitial());
  final AuthRepo signupRepo;
  User? user;
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

  void getSuggestedUsernames() async {
    signupRepo.getSuggestedUsernames().then((value) {
      emit(SuggestedUsername(value));
      debugPrint("after emitting suggested usernames ${value.toString()}");
    });
  }

 void checkOnUsername(String username) async {
    signupRepo.checkOnUsername(username).then((value) {
      emit(UserNameAvialable(value));
      debugPrint("after emitting username available $value");
    });
  }

  /// change the profile photo from web: send to the backend the new image
  void changeProfilephotoWeb(User? userWithPP, Uint8List fileAsBytes) {
    if (isClosed) return;
    signupRepo.updateImageWeb('profilephoto', fileAsBytes).then((image) {
      userWithPP?.profilePic = image as String?;
      debugPrint("image from cubit: $image");
      emit(SignedInWithProfilePhoto(userWithPP));
    });
  }
}
