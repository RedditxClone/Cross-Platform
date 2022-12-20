// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/presentation/screens/search/comments_web_search.dart';
import 'package:reddit/presentation/screens/search/communities_web_search.dart';
import 'package:reddit/presentation/screens/search/people_web_search.dart';
import 'package:reddit/presentation/screens/search/posts_web_search.dart';
import '../../../business_logic/cubit/cubit/search/cubit/search_comments_cubit.dart';
import '../../../business_logic/cubit/cubit/search/cubit/search_communities_cubit.dart';
import '../../../business_logic/cubit/cubit/search/cubit/search_people_cubit.dart';
import '../../../business_logic/cubit/cubit/search/cubit/search_posts_cubit.dart';

class SearchTabsMobile extends StatefulWidget {
  const SearchTabsMobile({super.key});

  @override
  State<SearchTabsMobile> createState() => _SearchTabsMobileState();
}

class _SearchTabsMobileState extends State<SearchTabsMobile> {
  static const tabTitleStyle = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      animationDuration: Duration.zero,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2, color: Colors.white),
              insets: EdgeInsets.symmetric(horizontal: 25),
            ),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 131, 122, 122),
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Posts",
                  style: tabTitleStyle,
                ),
              ),
              Tab(
                child: Text(
                  "Comments",
                  style: tabTitleStyle,
                ),
              ),
              Tab(
                child: Text(
                  "Communities",
                  style: tabTitleStyle,
                ),
              ),
              Tab(
                child: Text(
                  "People",
                  style: tabTitleStyle,
                ),
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            Expanded(
              // flex: 3,
              child: TabBarView(
                children: <Widget>[
                  BlocProvider.value(
                    value: BlocProvider.of<SearchPostsCubit>(context),
                    child: const PostsWebSearch(),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<SearchCommentsCubit>(context),
                    child: const CommentsWebSearch(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<SearchCommunitiesCubit>(context),
                      ),
                    ],
                    child: const CommunitiesWebSearch(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<SearchPeopleCubit>(context),
                      ),
                    ],
                    child: const PeopleWebSearch(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
