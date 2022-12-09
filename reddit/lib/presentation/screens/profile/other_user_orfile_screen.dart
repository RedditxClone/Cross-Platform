import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

class OtherProfileScreen extends StatefulWidget {
  final User otherUser;
  const OtherProfileScreen({required this.otherUser, super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  /// [context] : build context.
  /// [color] : color of the error msg to be displayer e.g. ('red' : error , 'blue' : success ).
  /// [title] : message to be displayed to the user.
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 9,
              ),
              Logo(
                Logos.reddit,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.no_sim_outlined,
          size: 70,
        ),
        SizedBox(height: 10),
        Text(
          'Wow, such empty',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget _follow() {
    return SizedBox(
      width: 80,
      child: OutlinedButton(
          onPressed: () {
            BlocProvider.of<UserProfileCubit>(context).follow(
                "6391e21409dfc46c3d93189d"); // TODO :  change this to the id of the other user
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(width: 1.0, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          child: const Text(
            'Follow',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
    );
  }

  Widget _unfollow() {
    return SizedBox(
      width: 126,
      child: OutlinedButton(
          onPressed: () {
            BlocProvider.of<UserProfileCubit>(context).unfollow(
                "6391e21409dfc46c3d93189d"); // TODO :  change this to the id of the other user
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(width: 1.0, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.check_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                'Following',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          )),
    );
  }

  Widget _appBarContent() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        // cover photo
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.redAccent, Colors.black]))),
        // add social links
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: 55,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: const Icon(
                              Icons.message_outlined,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(width: 10),
                      BlocBuilder<UserProfileCubit, UserProfileState>(
                        builder: (context, state) {
                          if (state is FollowOtherUserSuccess) {
                            return _unfollow();
                          } else if (state is UnFollowOtherUserSuccess) {
                            return _follow();
                          }
                          return _follow();
                        },
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: const Text(
                              'Invite',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(widget.otherUser.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 10),
              Text('u/${widget.otherUser.name} . 1 karma . 3 Oct 2022',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 10),
              const Text(
                  'about this user bla bla bla bla...', // TODO : replace this text with the about of the user
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 40),
            ],
          ),
        )
      ],
    );
  }

  Widget tabBar() {
    return Scaffold(
        appBar: AppBar(
      toolbarHeight: 0,
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      bottom: const TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0, color: Colors.blue),
          insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
        ),
        tabs: [
          Tab(text: 'Posts'),
          Tab(text: 'Comments'),
          Tab(text: 'About'),
        ],
      ),
    ));
  }

  Widget _upperAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            const CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.person,
                  size: 20,
                )),
            const SizedBox(width: 10),
            Text(widget.otherUser.displayName),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.file_upload_outlined, size: 30)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_horiz, size: 30)),
          ],
        ),
      ],
    );
  }

  Widget _buildPosts() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Posts(),
          Posts(),
          Posts(),
          Posts(),
          Posts(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.black,
      child: TabBarView(
        children: [
          _buildPosts(),
          _empty(),
          _empty(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (_, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              stretch: true,
              expandedHeight: 350,
              title: _upperAppBar(),
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: _appBarContent(),
              ),
              backgroundColor: Colors.redAccent,
              pinned: true,
              bottom: const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Colors.blue),
                  insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                ),
                tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Comments'),
                  Tab(text: 'About'),
                ],
              ),
            ),
          ];
        },
        body: BlocListener<UserProfileCubit, UserProfileState>(
            listener: (context, state) {
              if (state is FollowOtherUserSuccess) {
                displayMsg(context, Colors.green,
                    ' Followed u/${widget.otherUser.name}');
              } else if (state is FollowOtherUserNotSuccess) {
                displayMsg(context, Colors.red,
                    'An error has occured. please try again later');
              } else if (state is UnFollowOtherUserSuccess) {
                displayMsg(context, Colors.green,
                    ' Unfollowed u/${widget.otherUser.name}');
              } else if (state is UnFollowOtherUserNotSuccess) {
                displayMsg(context, Colors.red,
                    'An error has occured. please try again later');
              }
            },
            child: _buildBody()),
      ),
    ));
  }
}
