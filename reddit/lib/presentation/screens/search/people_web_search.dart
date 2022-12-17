// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';

class PeopleWebSearch extends StatefulWidget {
  const PeopleWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<PeopleWebSearch> createState() => _PeopleWebSearchState(searchTerm);
}

class _PeopleWebSearchState extends State<PeopleWebSearch> {
  final String? searchTerm;

  _PeopleWebSearchState(this.searchTerm);
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).searchPeople(searchTerm ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
