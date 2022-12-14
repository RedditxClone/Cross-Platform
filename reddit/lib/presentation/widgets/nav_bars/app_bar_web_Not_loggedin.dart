import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/helper/utils/shared_keys.dart';
import 'package:reddit/presentation/widgets/nav_bars/popup_menu_not_logged_in.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../helper/utils/shared_pref.dart';
import '../search_results.dart';

class AppBarWebNotLoggedIn extends StatefulWidget {
  final String screen;

  const AppBarWebNotLoggedIn({Key? key, required this.screen})
      : super(key: key);

  @override
  State<AppBarWebNotLoggedIn> createState() => _AppBarWebNotLoggedInState();
}

class _AppBarWebNotLoggedInState extends State<AppBarWebNotLoggedIn> {
  static const historyLength = 5; //max number of search history items
  final List<String> _searchHistory =
      []; //we wiil user this list reversed so the last item will be the first item in the list
  late FloatingSearchBarController _searchBarController;
  String? selectedTerm;

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
  }

  void _onFocusChangeSearch(bool isFocused) {
    // if (searchFocusNode.hasFocus) {
    //   // showSearch(context: context, delegate: MySearchWidget());
    // }
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
      await PreferenceUtils.setStringList(
          SharedPrefKeys.searchHistoryList, _searchHistory);
    }
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, homePageRoute),
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Logo(Logos.reddit, color: Colors.white, size: 30)),
              const SizedBox(width: 10),
              MediaQuery.of(context).size.width < 940
                  ? const SizedBox(width: 0)
                  : const Text('reddit'),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(
                context, popularPageRoute,
                arguments: null),
            hoverColor: Colors.transparent,
            child: Row(
              children: [
                const Icon(Icons.arrow_circle_up_rounded, size: 25),
                const SizedBox(width: 4),
                MediaQuery.of(context).size.width > 1000
                    ? Text(
                        widget.screen,
                        style: const TextStyle(fontSize: 13),
                      )
                    : const SizedBox(width: 0)
              ],
            ),
          ),
        ),
        SizedBox(
          width: 0.38 * MediaQuery.of(context).size.width,
          height: 50,
          //   child: TextField(
          //       focusNode: searchFocusNode,
          //       textAlignVertical: TextAlignVertical.center,
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //           borderSide: const BorderSide(
          //               width: 1, color: Color.fromRGBO(50, 50, 50, 100)),
          //           borderRadius: BorderRadius.circular(50.0),
          //         ),
          //         filled: true,
          //         hintText: "Search Reddit",
          //         isDense: true,
          //         hoverColor: const Color.fromRGBO(70, 70, 70, 100),
          //         fillColor: const Color.fromRGBO(50, 50, 50, 100),
          //         prefixIcon: const Icon(
          //           Icons.search,
          //           size: 25,
          //         ),
          //       )),
          child: FloatingSearchBar(
            onFocusChanged: (isFocused) {
              _onFocusChangeSearch(isFocused);
              setState(() {
                if (!isFocused) {
                  _searchBarController.close();
                } else {
                  _searchBarController.open();
                }
              });
            },
            hint: "Search Reddit",
            hintStyle: const TextStyle(fontSize: 15),
            backdropColor: Colors.transparent,
            border: const BorderSide(
                width: 1, color: Color.fromRGBO(50, 50, 50, 100)),
            borderRadius: BorderRadius.circular(50.0),
            height: 40,
            controller: _searchBarController,
            title: Text(
              selectedTerm ?? "Search Reddit",
              style: const TextStyle(fontSize: 15),
            ),
            leadingActions: [
              FloatingSearchBarAction(
                showIfOpened: true,
                child: CircularButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchBarController.open();
                  },
                ),
              ),
            ],
            actions: [
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
                color: Colors.white,
              ),
            ],
            body: FloatingSearchBarScrollNotifier(
              child: SearchResultsListView(
                searchTerm: selectedTerm,
              ),
            ),
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4,
                  child: Builder(
                    builder: (context) {
                      if (_searchHistory.isEmpty &&
                          _searchBarController.query.isEmpty) {
                        return Container(
                          height: 56,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Start searching',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        );
                      } else if (_searchHistory.isEmpty) {
                        return ListTile(
                          title: Text(_searchBarController.query),
                          leading: const Icon(Icons.search),
                          onTap: () {
                            setState(() {
                              addSearchTerm(_searchBarController.query);
                              selectedTerm = _searchBarController.query;
                            });
                            _searchBarController.close();
                          },
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _searchHistory
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
                                    });
                                    _searchBarController.close();
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              );
            },
            transition: CircularFloatingSearchBarTransition(),
            onSubmitted: (query) {
              //navigate to search page
              //request all kinds of the search results
              //this funtion is called when the user press enter or it presses the search button
              debugPrint("go for search");
              setState(() {
                selectedTerm = query;
                addSearchTerm(query);
              });
              _searchBarController.close();
            },
          ),
        ),
        Row(
          children: [
            MediaQuery.of(context).size.width > 800
                ? OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(SIGNU_PAGE1),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        side: const BorderSide(width: 1, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : const SizedBox(width: 0),
            const SizedBox(width: 20),
            MediaQuery.of(context).size.width > 800
                ? ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(loginPage),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                : const SizedBox(width: 0),
            SizedBox(width: MediaQuery.of(context).size.width < 600 ? 20 : 10),
            const PopupMenuNotLoggedIn(),
          ],
        ),
      ],
    );
  }
}
