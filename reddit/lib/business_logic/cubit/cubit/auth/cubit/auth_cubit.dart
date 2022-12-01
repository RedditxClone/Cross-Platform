// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/signin.dart';
import '../../../../../data/repository/singup_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signupRepo) : super(AuthInitial());
  final SignupRepo signupRepo;
  User? user;
  Future<User?> signup(String password, String username, String email) async {
    await signupRepo.signup(password, username, email).then((value) {
      user = value;
      emit(SignedIn(user));
      debugPrint("after emitting ${user?.email}");
    });
    return user;
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
