import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sort_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortInitial());
  void sort(String sort) {
    if (sort == "new") {
      emit(SortNew());
    } else if (sort == "hot") {
      emit(SortHot());
    } else if (sort == "best") {
      emit(SortBest());
    } else if (sort == "top") {
      emit(SortTop());
    }
  }
}
