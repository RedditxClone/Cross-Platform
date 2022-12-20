import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/create_community_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
part 'create_community_state.dart';

class CreateCommunityCubit extends Cubit<CreateCommunityState> {
  late CreateCommunityRepository createCommunityRepository;
  CreateCommunityCubit(this.createCommunityRepository)
      : super(CreateCommunityInitial());

  void createCommunity(CreateCommunityModel createCommunityModel) {
    if (isClosed) return;
    createCommunityRepository
        .createCommunity(createCommunityModel)
        .then((subredditModel) {
      print(subredditModel);
      if (subredditModel != null) {
        emit(CreateCommunityCreated(subredditModel));
      } else {
        emit(CreateCommunityFailedToCreate());
      }
    });
  }

  void createBloc() {
    if (isClosed) return;
    emit(CreateCommunityCreateBloc(CreateCommunityModel('', 'Public', false)));
  }

  void editName() {
    if (isClosed) return;
    emit(CreateCommunityNameChange());
  }

  checkIfNameAvailable(String subredditName) async {
    if (isClosed) return;
    final ifAvailable =
        await createCommunityRepository.getIfNameAvailable(subredditName);
    if (ifAvailable) {
      emit(CreateCommunityNameAvailable());
    } else {
      emit(CreateCommunityNameUnAvailable());
    }
  }

  void createButtonPressed() {
    if (isClosed) return;
    emit(CreateCommunityPressed());
  }

  void toggleAbove18() {
    if (isClosed) return;
    emit(CreateCommunityAbove18Change());
  }

  void changeType() {
    if (isClosed) return;
    emit(CreateCommunityTypeChange());
  }
}
