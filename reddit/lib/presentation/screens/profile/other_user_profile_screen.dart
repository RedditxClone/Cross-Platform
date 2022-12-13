import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

class OtherProfileScreen extends StatefulWidget {
  final String userID;
  const OtherProfileScreen({required this.userID, super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  User? otherUser;
  @override
  void initState() {
    super.initState();
    print(widget.userID);
    BlocProvider.of<UserProfileCubit>(context).getUserInfo(widget.userID);
  }

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
            BlocProvider.of<UserProfileCubit>(context).follow(widget.userID);
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
            BlocProvider.of<UserProfileCubit>(context).unfollow(widget
                .userID); // TODO :  change this to the id of the other user
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
              Text(
                  otherUser!.displayName == ''
                      ? otherUser!.username
                      : otherUser!.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 10),
              Text('u/${otherUser!.username} . 1 karma . 3 Oct 2022',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 5),
              Text(otherUser!.about!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 60),
            ],
          ),
        )
      ],
    );
  }

  void _moreOptionsBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            height: 170,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.person_off_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Block accout",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Send a message",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: const Color.fromRGBO(90, 90, 90, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Center(
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )),
              ],
            ),
          );
        });
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
            Text(
              otherUser!.displayName == ''
                  ? otherUser!.username
                  : otherUser!.displayName!,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.file_upload_outlined, size: 30)),
            IconButton(
                onPressed: () => _moreOptionsBottomSheet(context),
                icon: const Icon(Icons.more_horiz, size: 30)),
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

  Widget _buildAppBar() {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 320,
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
            BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                if (state is UserInfoAvailable) {
                  otherUser = state.userInfo;
                  return _buildAppBar();
                }
                if (state is FollowOtherUserSuccess ||
                    state is FollowOtherUserNotSuccess ||
                    state is UnFollowOtherUserSuccess ||
                    state is UnFollowOtherUserNotSuccess) {
                  return _buildAppBar();
                }
                return const SliverAppBar();
              },
            ),
          ];
        },
        body: BlocListener<UserProfileCubit, UserProfileState>(
            listener: (context, state) {
          if (state is FollowOtherUserSuccess) {
            displayMsg(
                context, Colors.green, ' Followed u/${otherUser!.username}');
          } else if (state is FollowOtherUserNotSuccess) {
            displayMsg(context, Colors.red,
                'An error has occured. please try again later');
          } else if (state is UnFollowOtherUserSuccess) {
            displayMsg(
                context, Colors.green, ' Unfollowed u/${otherUser!.username}');
          } else if (state is UnFollowOtherUserNotSuccess) {
            displayMsg(context, Colors.red,
                'An error has occured. please try again later');
          }
        }, child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserInfoAvailable) {
              otherUser = state.userInfo;
              return _buildBody();
            } else if (state is FollowOtherUserSuccess ||
                state is FollowOtherUserNotSuccess ||
                state is UnFollowOtherUserSuccess ||
                state is UnFollowOtherUserNotSuccess) {
              return _buildBody();
            }
            return const Center(child: CircularProgressIndicator());
          },
        )),
      ),
    ));
  }
}
