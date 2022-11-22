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
  late User? user;
  User? signup(String password, String username, String email) {
    signupRepo.signup(password, username, email).then((value) {
      user = value;
      emit(SignedIn(user));
      debugPrint("after emitting");
    });
    return user;
  }
}
