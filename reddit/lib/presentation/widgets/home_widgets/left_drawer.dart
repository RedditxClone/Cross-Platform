import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/business_logic/cubit/left_drawer/left_drawer_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/left_drawer/left_drawer_model.dart';

import '../../../data/model/auth_model.dart';
import '../../../data/repository/left_drawer/left_drawer_repository.dart';
import '../../../data/web_services/left_drawer/left_drawer_web_services.dart';

/// Build the UI of the left drawer of home page on android.
class LeftDrawer extends StatefulWidget {
  LeftDrawer({Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  late LeftDrawerRepository leftDrawerRepository =
      LeftDrawerRepository(LeftDrawerWebServices());

  List<LeftDrawerModel>? _moderating;
  List<LeftDrawerModel>? _yourCommunities;
  List<LeftDrawerModel>? _following;
  List<LeftDrawerModel>? _favorites;
  @override
  void initState() {
    super.initState();
    if (UserData.isLoggedIn) {
      BlocProvider.of<LeftDrawerCubit>(context).getLeftDrawerData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 300,
      child: UserData.isLoggedIn
          ? _buildLoggedInEndDrawer(context)
          : _buildLoggedOutEndDrawer(context),
    );
  }

  /// Build the UI of the left drawer when the user is logged in
  Widget _buildLoggedInEndDrawer(context) {
    return SafeArea(
      child: Column(
        children: [
          _buildScrollViewButtons(),
        ],
      ),
    );
  }

  /// Build the UI of the end drawer when the user is logged out
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

  /// Build the UI of the scroll view buttons of the right drawer
  Widget _buildScrollViewButtons() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<LeftDrawerCubit, LeftDrawerState>(
            builder: (context, state) {
              if (state is LeftDrawerDataLoaded) {
                _moderating = state.moderating;
                _yourCommunities = state.yourCommunities;
                _following = state.following;
                _favorites = state.favorites;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _favorites!.isNotEmpty
                        ? ExpansionTile(
                            initiallyExpanded: true,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            maintainState: true,
                            title: const Text("Favorites"),
                            // Children are the subreddits that you are currently moderating
                            children: [
                              ..._favorites!.map(
                                (e) {
                                  return ListTile(
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      radius: 15.0,
                                      backgroundImage: NetworkImage(e.image!),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: Text("r/${e.name}"),
                                    trailing: IconButton(
                                        onPressed: () {
                                          _removeFromFavorites(e);
                                        },
                                        icon: const Icon(Icons.star)),
                                  );
                                },
                              ).toList(),
                            ],
                          )
                        : const SizedBox(),
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      maintainState: true,
                      title: const Text("Moderation"),
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ..._moderating!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
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
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.plus),
                          title: const Text("Create a community"),
                          onTap: () {
                            // TODO: got to create community page
                            Navigator.pushNamed(
                                context, createCommunityScreenRoute);
                          },
                        ),
                        ..._yourCommunities!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
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
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ..._following!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
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
                );
              } else
                return Container();
            },
          ),
        ),
      ),
    );
  }

  /// Add a subreddit or user to favorites
  void _addToFavorites(LeftDrawerModel leftDrawerModel) {
    BlocProvider.of<LeftDrawerCubit>(context).addToFavorites(leftDrawerModel);
  }

  /// Remove a subreddit or user from favorites
  void _removeFromFavorites(LeftDrawerModel leftDrawerModel) {
    BlocProvider.of<LeftDrawerCubit>(context)
        .removeFromFavorites(leftDrawerModel);
  }
}
