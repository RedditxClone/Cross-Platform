import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/colors.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import '../../../constants/theme_colors.dart';

class PostsWebSearch extends StatefulWidget {
  final String? searchTerm;
  const PostsWebSearch({super.key, this.searchTerm});

  @override
  // ignore: no_logic_in_create_state
  State<PostsWebSearch> createState() => _PostsWebSearchState(searchTerm);
}

class _PostsWebSearchState extends State<PostsWebSearch> {
  final String? searchTerm;
  _PostsWebSearchState(this.searchTerm);

  List<PopupMenuEntry> sortOptionsList = [
    PopupMenuItem(
      value: 0,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Relevance',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 1,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Hot',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Top',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 3,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'New',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 4,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Most Comments',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  ];
  List<PopupMenuEntry> timeOptionsList = [
    PopupMenuItem(
      value: 0,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'All Time',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 1,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Year',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Month',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 3,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Week',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 4,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past 24 Hours',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 5,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Hour',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  ];
  String sortOption = "Sort by";
  String sortTime = "Time";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state is GetSearchPosts) {
            debugPrint("GetSearchPosts");
            return Row(
              children: [
                PopupMenuButton(
                  color: defaultSecondaryColor,
                  position: PopupMenuPosition.under,
                  itemBuilder: (_) => sortOptionsList,
                  onSelected: (value) {
                    if (value == 0) {
                      sortOption = "Relevance";
                    } else if (value == 1) {
                      sortOption = "Hot";
                    } else if (value == 2) {
                      sortOption = "Top";
                    } else if (value == 3) {
                      sortOption = "New";
                    } else if (value == 4) {
                      sortOption = "Most Comments";
                    }
                    BlocProvider.of<SearchCubit>(context)
                        .searchPosts(searchTerm ?? "", value as int);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: textFeildColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          sortOption,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Icon(Icons.arrow_downward_rounded),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton(
                  color: defaultSecondaryColor,
                  position: PopupMenuPosition.under,
                  itemBuilder: (_) => sortOptionsList,
                  onSelected: (value) {
                    if (value == 0) {
                      sortTime = "All Time";
                    } else if (value == 1) {
                      sortTime = "Past Year";
                    } else if (value == 2) {
                      sortTime = "Past Month";
                    } else if (value == 3) {
                      sortTime = "Past Week";
                    } else if (value == 4) {
                      sortTime = "Past 24 Hours";
                    } else if (value == 5) {
                      sortTime = "Past Hour";
                    }
                    BlocProvider.of<SearchCubit>(context)
                        .searchPosts(searchTerm ?? "", value as int);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: textFeildColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          sortTime,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Icon(Icons.arrow_downward_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox(
            height: 0,
          );
        }),
      ),
      body: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
