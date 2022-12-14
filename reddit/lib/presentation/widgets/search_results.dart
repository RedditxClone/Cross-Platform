import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchResultsListView extends StatelessWidget {
  final String? searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      // return Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       const Icon(
      //         Icons.search,
      //         size: 64,
      //       ),
      //       Text(
      //         'Start searching',
      //         style: Theme.of(context).textTheme.headline5,
      //       )
      //     ],
      //   ),
      // );
      return const SizedBox.shrink();
    }

    final fsb = FloatingSearchBar.of(context);

    //   return ListView(
    //     padding: EdgeInsets.only(
    //         top: fsb!.widget.height + fsb.widget.margins!.vertical),
    //     children: List.generate(
    //       5,
    //       (index) => ListTile(
    //         title: Text(searchTerm ?? ""),
    //         subtitle: Text(index.toString()),
    //       ),
    //     ),
    //   );
    return Container();
  }
}
