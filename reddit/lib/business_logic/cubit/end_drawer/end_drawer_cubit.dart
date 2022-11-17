import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';

part 'end_drawer_state.dart';

class EndDrawerCubit extends Cubit<EndDrawerState> {
  final EndDrawerRepository endDrawerRepository;
  EndDrawerCubit(this.endDrawerRepository) : super(EndDrawerInitial());

  /// change the profile photo from mobile: send to the backend the new image
  /// change the profile photo from mobile: send to the backend the new image
  void changeProfilephoto(File img) {
    endDrawerRepository.updateImage('profilephoto', img).then((image) {
      emit(EndDrawerProfilePictureChanged(image));
    });
  }
}
