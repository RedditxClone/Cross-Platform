// ignore_for_file: no_logic_in_create_state

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';

class CommentsWebSearch extends StatefulWidget {
  const CommentsWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<CommentsWebSearch> createState() => _CommentsWebSearchState(searchTerm);
}

class _CommentsWebSearchState extends State<CommentsWebSearch> {
  final String? searchTerm;

  _CommentsWebSearchState(this.searchTerm);
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).searchComments(searchTerm ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
