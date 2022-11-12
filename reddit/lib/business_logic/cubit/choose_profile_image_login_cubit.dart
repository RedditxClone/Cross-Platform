import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/settings_repository.dart';

part 'choose_profile_image_login_state.dart';

class ChooseProfileImageLoginCubit extends Cubit<ChooseProfileImageLoginState> {
  SettingsRepository settingsRepository;
  ChooseProfileImageLoginCubit(this.settingsRepository)
      : super(ChooseProfileImageLoginInitial());

  void changeProfilephoto(File img) {
    settingsRepository.updateImage('profilephoto', img).then((image) {
      emit(ChooseProfileImageLoginChanged(image));
    });
  }
}
