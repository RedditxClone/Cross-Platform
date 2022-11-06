import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/constants/strings.dart';

class LeftDrawer extends StatelessWidget {
  late bool _isLoggedIn;
  final List<Map<String, dynamic>> _moderating = [
    {
      "name": "redditxx",
      "image": Icons.person,
      "favorite": true,
    },
  ];
  final List<Map<String, dynamic>> _yourCommunities = [
    {
      "name": "announcements",
      "image": Icons.announcement,
      "favorite": false,
    },
  ];
  final List<Map<String, dynamic>> _following = [
    {
      "name": "mark",
      "image": Icons.person,
      "favorite": true,
    },
  ];
  List<Map<String, dynamic>> _favorites = [];
  LeftDrawer(this._isLoggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 300,
      child: _isLoggedIn
          ? _buildLoggedInEndDrawer(context)
          : _buildLoggedOutEndDrawer(context),
    );
  }

  Widget _buildLoggedInEndDrawer(context) {
    return SafeArea(
      child: Column(
        children: [
          _buildScrollViewButtons(),
        ],
      ),
    );
  }

  Widget _buildLoggedOutEndDrawer(context) {
    return SafeArea(
        child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.stacked_bar_chart),
          title: const Text("All"),
          onTap: () {
            // TODO: open a page with random posts
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Login to add your communities"),
          onTap: () {
            // TODO: open login dropdown
          },
        )
      ],
    ));
  }

  Widget _buildScrollViewButtons() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                textColor: Colors.white,
                iconColor: Colors.white,
                maintainState: true,
                title: const Text("Moderation"),
                // Children are the subreddits that you are currently moderating
                children: [
                  ..._moderating.map(
                    (e) {
                      return ListTile(
                        onTap: () {},
                        leading: Icon(e["image"]),
                        title: Text("r/${e["name"]}"),
                        trailing: e["favorite"]
                            ? IconButton(
                                onPressed: () {
                                  _removeFromFavorites();
                                },
                                icon: const Icon(Icons.star_border))
                            : IconButton(
                                onPressed: () {
                                  _addToFavorites();
                                },
                                icon: const Icon(Icons.star)),
                      );
                    },
                  ).toList(),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                textColor: Colors.white,
                iconColor: Colors.white,
                maintainState: true,
                title: const Text("Your Communities"),
                // Children are the subreddits that you joined
                children: [
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.plus),
                    title: const Text("Create a community"),
                    onTap: () {
                      // TODO: got to create community page
                    },
                  ),
                  ..._yourCommunities.map(
                    (e) {
                      return ListTile(
                        onTap: () {},
                        leading: Icon(e["image"]),
                        title: Text("r/${e["name"]}"),
                        trailing: e["favorite"]
                            ? IconButton(
                                onPressed: () {
                                  _removeFromFavorites();
                                },
                                icon: const Icon(Icons.star_border))
                            : IconButton(
                                onPressed: () {
                                  _addToFavorites();
                                },
                                icon: const Icon(Icons.star)),
                      );
                    },
                  ).toList(),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                textColor: Colors.white,
                iconColor: Colors.white,
                maintainState: true,
                title: const Text("Following"),
                // Children are the subreddits that you joined
                children: [
                  ..._following.map(
                    (e) {
                      return ListTile(
                        onTap: () {},
                        leading: Icon(e["image"]),
                        title: Text("r/${e["name"]}"),
                        trailing: e["favorite"]
                            ? IconButton(
                                onPressed: () {
                                  _removeFromFavorites();
                                },
                                icon: const Icon(Icons.star_border))
                            : IconButton(
                                onPressed: () {
                                  _addToFavorites();
                                },
                                icon: const Icon(Icons.star)),
                      );
                    },
                  ).toList(),
                ],
              ),
              // All button
              ListTile(
                leading: const Icon(Icons.stacked_bar_chart),
                title: const Text("All"),
                onTap: () {
                  // TODO: open a page where the user sees posts from all the communities
                  // joint, moderating, and following accounts
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // TODO: complete these functions
  void _addToFavorites() {}
  void _removeFromFavorites() {}
}
