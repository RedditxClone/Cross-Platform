// ignore_for_file: no_logic_in_create_state

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';

class CommunitiesWebSearch extends StatefulWidget {
  const CommunitiesWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<CommunitiesWebSearch> createState() =>
      _CommunitiesWebSearchState(searchTerm);
}

class _CommunitiesWebSearchState extends State<CommunitiesWebSearch> {
  final String? searchTerm;

  _CommunitiesWebSearchState(this.searchTerm);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).searchCommunities(searchTerm ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
