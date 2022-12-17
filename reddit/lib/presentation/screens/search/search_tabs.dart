import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import 'package:reddit/data/repository/search_repo.dart';
import 'package:reddit/data/web_services/search_web_service.dart';
import 'package:reddit/presentation/screens/search/comments_web_search.dart';
import 'package:reddit/presentation/screens/search/communities_web_search.dart';
import 'package:reddit/presentation/screens/search/people_web_search.dart';
import 'package:reddit/presentation/screens/search/posts_web_search.dart';

import '../../../constants/responsive.dart';
import '../../../constants/theme_colors.dart';

class SearchTabs extends StatefulWidget {
  const SearchTabs({super.key, required this.searchTerm});
  final String? searchTerm;

  @override
  // ignore: no_logic_in_create_state
  State<SearchTabs> createState() => _SearchTabsState(searchTerm);
}

class _SearchTabsState extends State<SearchTabs> {
  final String? searchTerm;
  static const tabTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  late Responsive responsive;

  _SearchTabsState(this.searchTerm);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
              flex: responsive.isSmallSizedScreen() ? 0 : 1,
              child: const SizedBox(width: 1)),
          Expanded(
            flex: 6,
            child: DefaultTabController(
              length: 4,
              animationDuration: Duration.zero,
              child: Container(
                margin: EdgeInsets.only(
                    top: responsive.isSmallSizedScreen() ? 0 : 20),
                height: MediaQuery.of(context).size.height * 1.2,
                // height: 1400,
                color: Colors.transparent,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    bottom: TabBar(
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal: 25),
                      ),
                      padding: EdgeInsets.only(
                          right: responsive.isXLargeSizedScreen()
                              ? 500
                              : responsive.isLargeSizedScreen()
                                  ? 300
                                  : responsive.isMediumSizedScreen()
                                      ? 100
                                      : 0),
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          const Color.fromARGB(255, 131, 122, 122),
                      tabs: const <Widget>[
                        Tab(
                          child: Text(
                            "Posts",
                            style: tabTitleStyle,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Commetns",
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
                              value: BlocProvider.of<SearchCubit>(context),
                              child: const PostsWebSearch(),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<SearchCubit>(context),
                              child: const CommentsWebSearch(),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<SearchCubit>(context),
                              child: const CommunitiesWebSearch(),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<SearchCubit>(context),
                              child: const PeopleWebSearch(),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   flex: responsive.isSmallSizedScreen()
                      //       ? 0
                      //       : responsive.isMediumSizedScreen()
                      //           ? 1
                      //           : responsive.isLargeSizedScreen()
                      //               ? 2
                      //               : 3,
                      //   child: const SizedBox(width: 1),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class SearchTabs extends StatelessWidget {
//   final String? searchTerm;
//   static const tabTitleStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );
//   late Responsive responsive;

//   SearchTabs({this.searchTerm, super.key});

//   @override
//   Widget build(BuildContext context) {
//     responsive = Responsive(context);
//     return SingleChildScrollView(
//       child: Row(
//         children: [
//           Expanded(
//               flex: responsive.isSmallSizedScreen() ? 0 : 1,
//               child: const SizedBox(width: 1)),
//           Expanded(
//             flex: 6,
//             child: DefaultTabController(
//               length: 4,
//               animationDuration: Duration.zero,
//               child: Container(
//                 margin: EdgeInsets.only(
//                     top: responsive.isSmallSizedScreen() ? 0 : 20),
//                 height: 1400,
//                 color: Colors.transparent,
//                 child: Scaffold(
//                   backgroundColor: Colors.transparent,
//                   appBar: AppBar(
//                     elevation: 0,
//                     automaticallyImplyLeading: false,
//                     backgroundColor: Colors.transparent,
//                     bottom: TabBar(
//                       indicator: const UnderlineTabIndicator(
//                         borderSide: BorderSide(width: 2, color: Colors.white),
//                         insets: EdgeInsets.symmetric(horizontal: 25),
//                       ),
//                       padding: EdgeInsets.only(
//                           right: responsive.isXLargeSizedScreen()
//                               ? 500
//                               : responsive.isLargeSizedScreen()
//                                   ? 300
//                                   : responsive.isMediumSizedScreen()
//                                       ? 100
//                                       : 0),
//                       indicatorColor: Colors.white,
//                       labelColor: Colors.white,
//                       unselectedLabelColor:
//                           const Color.fromARGB(255, 131, 122, 122),
//                       tabs: const <Widget>[
//                         Tab(
//                           child: Text(
//                             "Posts",
//                             style: tabTitleStyle,
//                           ),
//                         ),
//                         Tab(
//                           child: Text(
//                             "Commetns",
//                             style: tabTitleStyle,
//                           ),
//                         ),
//                         Tab(
//                           child: Text(
//                             "Communities",
//                             style: tabTitleStyle,
//                           ),
//                         ),
//                         Tab(
//                           child: Text(
//                             "People",
//                             style: tabTitleStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   body: Row(
//                     children: [
//                       Expanded(
//                         // flex: 3,
//                         child: TabBarView(
//                           children: <Widget>[
//                             BlocProvider.value(
//                               value: BlocProvider.of<SearchCubit>(context),
//                               child: const PostsWebSearch(),
//                             ),
//                             BlocProvider.value(
//                               value: BlocProvider.of<SearchCubit>(context),
//                               child: const CommentsWebSearch(),
//                             ),
//                             BlocProvider.value(
//                               value: BlocProvider.of<SearchCubit>(context),
//                               child: const CommunitiesWebSearch(),
//                             ),
//                             BlocProvider.value(
//                               value: BlocProvider.of<SearchCubit>(context),
//                               child: const PeopleWebSearch(),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Expanded(
//                       //   flex: responsive.isSmallSizedScreen()
//                       //       ? 0
//                       //       : responsive.isMediumSizedScreen()
//                       //           ? 1
//                       //           : responsive.isLargeSizedScreen()
//                       //               ? 2
//                       //               : 3,
//                       //   child: const SizedBox(width: 1),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
