import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/create_community_model.dart';
import 'package:reddit/data/repository/community_repo.dart';
part 'create_community_state.dart';

class CreateCommunityCubit extends Cubit<CreateCommunityState> {
  late CreateCommunityRepository createCommunityRepository;
  CreateCommunityCubit(this.createCommunityRepository)
      : super(CreateCommunityInitial());

  void createCommunity(CreateCommunityModel createCommunityModel) {
    createCommunityRepository.createCommunity(createCommunityModel);
    emit(CreateCommunityCreated());
  }

  void createBloc() {
    emit(CreateCommunityCreateBloc(CreateCommunityModel('', 'Public', false)));
  }

  void editName() {
    emit(CreateCommunityNameChange());
  }

  checkIfNameAvailable(String subredditName) async {
    emit(CreateCommunityNameChange());
    final ifAvailable =
        await createCommunityRepository.getIfNameAvailable(subredditName);
    if (ifAvailable) {
      emit(CreateCommunityNameAvailable());
    } else {
      emit(CreateCommunityNameUnAvailable());
    }
  }

  void createButtonPressed() {
    emit(CreateCommunityPressed());
  }

  void toggleAbove18() {
    emit(CreateCommunityAbove18Change());
  }

  void changeType() {
    emit(CreateCommunityTypeChange());
  }
}
