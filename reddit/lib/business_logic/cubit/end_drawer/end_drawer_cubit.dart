import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';

part 'end_drawer_state.dart';

/// This class is responsible for getting - updating end drawer data on mobile.
class EndDrawerCubit extends Cubit<EndDrawerState> {
  final EndDrawerRepository endDrawerRepository;
  EndDrawerCubit(this.endDrawerRepository) : super(EndDrawerInitial());

  /// [img] : The new profile photo as a File
  /// Emits sate [EndDrawerProfilePictureChanged] on successfully updating profile photo (on mobile)
  /// This function calls the function [EndDrawerRepository.updateImage] that prepares the PATCH request
  void changeProfilephoto(File img) {
    endDrawerRepository.updateImage('profilephoto', img).then((image) {
      emit(EndDrawerProfilePictureChanged(image));
    });
  }
}
