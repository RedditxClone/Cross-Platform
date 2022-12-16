import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/search/search_tabs.dart';
import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import '../../../helper/utils/shared_keys.dart';
import '../../../helper/utils/shared_pref.dart';

class SearchWeb extends StatefulWidget {
  const SearchWeb({super.key});

  @override
  State<SearchWeb> createState() => _SearchWebState();
}

class _SearchWebState extends State<SearchWeb> {
  static const historyLength = 5; //max number of search history items
  late List<String>
      _searchHistory; //we wiil user this list reversed so the last item will be the first item in the list
  late FloatingSearchBarController _searchBarController;
  String? selectedTerm;
  String? currentQuery;
  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
    _searchHistory =
        PreferenceUtils.getStringList(SharedPrefKeys.searchHistoryList) ?? [];
  }

  void _onFocusChangeSearch(bool isFocused) {
    debugPrint("Focus on search: $isFocused");
  }

  @override
  void dispose() {
    super.dispose();
    _searchBarController.dispose();
  }

  Future<void> addSearchTerm(String newTerm) async {
    if (_searchHistory.contains(newTerm)) {
      putSearchTermFirst(newTerm);
      return;
    } else {
      //not contain
      _searchHistory.add(newTerm);
      if (_searchHistory.length > historyLength) {
        _searchHistory.removeAt(0);
      }
    }
    await PreferenceUtils.setStringList(
        SharedPrefKeys.searchHistoryList, _searchHistory);
  }

  Future<void> deleteSearchTerm(String term) async {
    _searchHistory.remove(term);
    await PreferenceUtils.setStringList(
        SharedPrefKeys.searchHistoryList, _searchHistory);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  DateTime? lastGetSuggetionTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: FloatingSearchBar(
          width: MediaQuery.of(context).size.width * 0.7,
          onQueryChanged: (query) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (_searchBarController.query.isNotEmpty &&
                  (lastGetSuggetionTime == null
                      ? true
                      : DateTime.now().difference(lastGetSuggetionTime!) >
                          const Duration(milliseconds: 500))) {
                BlocProvider.of<SearchCubit>(context)
                    .getSuggestions(_searchBarController.query);
                lastGetSuggetionTime = DateTime.now();
                debugPrint("lastGetSuggetionTime: $lastGetSuggetionTime");
              }
            });
            setState(() {
              currentQuery = query;
            });
          },
          hint: "Search Reddit",
          backdropColor: Colors.transparent,
          border: const BorderSide(
            width: 1,
            color: Color.fromRGBO(50, 50, 50, 100),
          ),
          borderRadius: BorderRadius.circular(50.0),
          height: 60,
          controller: _searchBarController,
          title: Text(
            selectedTerm != null ? selectedTerm! : currentQuery ?? "",
            style: const TextStyle(fontSize: 15),
          ),
          leadingActions: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: textFeildColor,
              ),
              child: InkWell(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, homePageRoute),
                hoverColor: Colors.transparent,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.red,
                        child:
                            Logo(Logos.reddit, color: Colors.white, size: 30)),
                    const SizedBox(width: 10),
                    MediaQuery.of(context).size.width < 940
                        ? const SizedBox(width: 0)
                        : const Text('reddit'),
                  ],
                ),
              ),
            ),
          ],
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          builder: (context, transition) {
            debugPrint(_searchHistory.toString());
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                elevation: 4,
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (_searchHistory.isEmpty &&
                        _searchBarController.query.isEmpty) {
                      return Container(
                        height: 56,
                        // width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Start searching',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    }
                    // else if (_searchHistory.isEmpty) {
                    //   debugPrint(
                    //       "Search history is empty and query is not empty");
                    //   return ListTile(
                    //     title: Text("Search for ${_searchBarController.query}"),
                    //     leading: const Icon(Icons.search),
                    //     onTap: () {
                    //       setState(() {
                    //         addSearchTerm(_searchBarController.query);
                    //         selectedTerm = _searchBarController.query;
                    //       });
                    //       _searchBarController.close();
                    //     },
                    //   );
                    // }
                    else if (_searchBarController.query.isEmpty) {
                      //a3rd ali gwa al list lo kan al query empty
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _searchHistory.reversed
                            .toList()
                            .map(
                              (term) => ListTile(
                                title: Text(
                                  term,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: const Icon(Icons.history),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      deleteSearchTerm(term);
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    putSearchTermFirst(term);
                                    selectedTerm = term;
                                    BlocProvider.of<SearchCubit>(context)
                                        .searchPosts(selectedTerm ?? "", 0);
                                    BlocProvider.of<SearchCubit>(context)
                                        .searchPeople(selectedTerm ?? "");
                                    BlocProvider.of<SearchCubit>(context)
                                        .searchComments(selectedTerm ?? "");
                                    BlocProvider.of<SearchCubit>(context)
                                        .searchCommunities(selectedTerm ?? "");
                                  });
                                  _searchBarController.close();
                                },
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      //get the suggetions from the data base if the quary not empty
                      if (state is GetSuggestions) {
                        debugPrint("get data of suggestions");
                        return Column(
                          children: [
                            state.suggestions[1].isEmpty
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : ListTile(
                                    title: const Text(
                                      "Comminities",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: state.suggestions[1]
                                          .map(
                                            (term) => ListTile(
                                              title: Text(
                                                "r/${term["name"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                "Community . ${term["users"]} members",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              // leading: term["img"] == "" TODO: add the image of the subreddits
                                              //     ? const Icon(Icons.reddit)
                                              //     : Image.network(term["img"]),
                                              leading: const Icon(Icons.reddit),
                                              onTap: () {
                                                //navigate to the subreddits page we can pass the ID and name of it and all the data needed
                                                setState(() {
                                                  selectedTerm = term["name"];
                                                });
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchPosts(
                                                        selectedTerm ?? "", 0);
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchPeople(
                                                        selectedTerm ?? "");
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchComments(
                                                        selectedTerm ?? "");
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchCommunities(
                                                        selectedTerm ?? "");
                                                _searchBarController.close();
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                            Divider(
                              color: state.suggestions[1].isEmpty
                                  ? Colors.transparent
                                  : Colors.grey,
                              height: state.suggestions[1].isEmpty ? 0 : 10,
                              thickness: state.suggestions[1].isEmpty ? 0 : 1,
                            ),
                            state.suggestions[0].isEmpty
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : ListTile(
                                    title: const Text(
                                      "People",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: state.suggestions[0]
                                          .map(
                                            (term) => ListTile(
                                              title: Text(
                                                "u/${term["username"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              subtitle: const Text(
                                                "User . 100 Karma",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              leading:
                                                  term["profilePhoto"] == ""
                                                      ? const Icon(Icons.reddit)
                                                      : Image.network(
                                                          term["profilePhoto"]),
                                              onTap: () {
                                                //navigate to the user page we can pass the ID and name of it and all the data needed
                                                setState(() {
                                                  selectedTerm =
                                                      term["username"];
                                                });
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchPosts(
                                                        selectedTerm ?? "", 0);
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchPeople(
                                                        selectedTerm ?? "");
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchComments(
                                                        selectedTerm ?? "");
                                                BlocProvider.of<SearchCubit>(
                                                        context)
                                                    .searchCommunities(
                                                        selectedTerm ?? "");
                                                _searchBarController.close();
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                          ],
                        );
                      }
                      return Container(
                        height: 56,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ),
            );
          },
          transition: CircularFloatingSearchBarTransition(),
          physics: const BouncingScrollPhysics(),
          onSubmitted: (query) {
            //navigate to search page
            //request all kinds of the search results
            //this funtion is called when the user press enter or it presses the search button
            if (query.isNotEmpty) {
              //to protect out database
              debugPrint("go for search");
              setState(() {
                selectedTerm = query;
                addSearchTerm(query);
              });
              BlocProvider.of<SearchCubit>(context)
                  .searchPosts(selectedTerm ?? "", 0);
              BlocProvider.of<SearchCubit>(context)
                  .searchPeople(selectedTerm ?? "");
              BlocProvider.of<SearchCubit>(context)
                  .searchComments(selectedTerm ?? "");
              BlocProvider.of<SearchCubit>(context)
                  .searchCommunities(selectedTerm ?? "");
            }
            _searchBarController.close();
          },
          body:
              BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
            return FloatingSearchBarScrollNotifier(
              child: SearchTabs(
                searchTerm: selectedTerm,
              ),
            );
          }),
        ),
      ),
    );
  }
}
