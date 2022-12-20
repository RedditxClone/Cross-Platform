import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_user_cubit.dart';
import 'package:reddit/business_logic/cubit/user_profile/follow_unfollow_cubit.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class OtherProfileScreen extends StatefulWidget {
  final String userID;
  const OtherProfileScreen({required this.userID, super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  User? otherUser;
  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.userID);
    BlocProvider.of<UserProfileCubit>(context).getUserInfo(widget.userID);
  }

  @override
  void dispose() {
    otherUser = null;
    super.dispose();
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

  Widget _indicateEmpty(String title, String subtitle) {
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            "assets/images/comments.jpg",
            scale: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ]),
    );
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
            UserData.isLoggedIn
                ? BlocProvider.of<FollowUnfollowCubit>(context)
                    .follow(otherUser!.userId!)
                : Navigator.pushNamed(context, loginScreen);
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
      width: 135,
      child: OutlinedButton(
          onPressed: () {
            BlocProvider.of<FollowUnfollowCubit>(context)
                .unfollow(otherUser!.userId!);
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
                  colors: [Colors.redAccent, Colors.black])),
          child: otherUser!.coverPhoto != ""
              ? Image.network(
                  otherUser!.coverPhoto,
                  fit: BoxFit.cover,
                )
              : null,
        ),
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
                  otherUser!.profilePic == null || otherUser!.profilePic == ''
                      ? const CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            otherUser!.profilePic!,
                          )),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      BlocBuilder<FollowUnfollowCubit, FollowUnfollowState>(
                        builder: (context, state) {
                          if (state is FollowOtherUserSuccess) {
                            return _unfollow();
                          } else if (state is UnFollowOtherUserSuccess) {
                            return _follow();
                          }
                          return otherUser!.isFollowed!
                              ? _unfollow()
                              : _follow();
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                  otherUser!.displayName == ''
                      ? otherUser!.username ?? ""
                      : otherUser!.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 10),
              Text(
                  'u/${otherUser!.username} . 1 karma . ${DateFormat('dd MMM yyyy').format(DateTime.parse(otherUser!.createdAt! == "" ? "2022-12-17T16:58:07.872Z" : UserData.user!.createdAt!))}',
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

  void _showBlockDialog(buildcontext) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Are you sure?"),
            content:
                const Text("Your won't see posts or comments from this user."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: defaultThirdColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
              ElevatedButton(
                onPressed: () => BlocProvider.of<UserProfileCubit>(buildcontext)
                    .blockUser(
                        otherUser!.userId ?? ""), // TODO : CHANGE TO USERNAME
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: const Text(
                  "BLOCK",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              )
            ],
          );
        });
  }

  void _sendMessageBottomSheet(BuildContext buildcontext) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        context: buildcontext,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (_) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Scaffold(
              appBar: AppBar(
                leading: CloseButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<MessagesCubit>(buildcontext)
                            .sendMessage(
                                subjectController.text,
                                messageController.text,
                                otherUser!.username ?? "");
                      },
                      child: const Text('Send', style: TextStyle(fontSize: 20)))
                ],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height - 50,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'u/ ${otherUser!.username}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 5),
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: InputBorder.none,
                        )),
                    const Divider(thickness: 1, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _moreOptionsBottomSheet(BuildContext buildcontext) {
    showModalBottomSheet(
        context: buildcontext,
        builder: (_) {
          return Container(
            height: UserData.isLoggedIn ? 170 : 120,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                UserData.isLoggedIn
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showBlockDialog(buildcontext);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.person_off_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text("Block account",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))
                          ],
                        ))
                    : const SizedBox(width: 0, height: 0),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      UserData.isLoggedIn
                          ? _sendMessageBottomSheet(buildcontext)
                          : Navigator.pushNamed(context, loginScreen);
                    },
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
                    onPressed: () => Navigator.pop(context),
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

  Widget _upperAppBar(buildcontext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            otherUser!.profilePic == null || otherUser!.profilePic == ''
                ? const CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      otherUser!.profilePic!,
                    )),
            const SizedBox(width: 10),
            Text(
              otherUser!.displayName == ''
                  ? otherUser!.username ?? ""
                  : otherUser!.displayName!,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Row(
          children: [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.file_upload_outlined, size: 30)),
            IconButton(
                onPressed: () => _moreOptionsBottomSheet(buildcontext),
                icon: const Icon(Icons.more_horiz, size: 30)),
          ],
        ),
      ],
    );
  }

  Widget _buildPosts() {
    return SingleChildScrollView(
      child: BlocBuilder<PostsUserCubit, PostsUserState>(
        builder: (context, state) {
          if (state is UserPostsLoaded) {
            if (state.posts!.isNotEmpty) {
              return Column(children: [
                ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
              ]);
            }
            return Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/comments.jpg",
                    scale: 3,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Create a post",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Expanded(flex: 3, child: Container()),
                    const Expanded(
                      flex: 20,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "No posts are available yet. Create a post now!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
              ]),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.black,
      child: TabBarView(
        children: [
          _buildPosts(),
          _indicateEmpty("Wow, such empty!", ""),
          _indicateEmpty("Wow, such empty!", ""),
        ],
      ),
    );
  }

  Widget _buildAppBar(buildcontext) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 320,
      title: _upperAppBar(buildcontext),
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
                      BlocProvider.of<PostsUserCubit>(context)
                          .getUserPosts(state.userInfo.userId ?? "", limit: 50);
                      return _buildAppBar(context);
                    }
                    // if (state is FollowOtherUserSuccess ||
                    //     state is FollowOtherUserNotSuccess ||
                    //     state is UnFollowOtherUserSuccess ||
                    //     state is UnFollowOtherUserNotSuccess) {
                    //   return _buildAppBar(context);
                    // }
                    return const SliverAppBar();
                  },
                ),
              ];
            },
            body: MultiBlocListener(
              listeners: [
                BlocListener<FollowUnfollowCubit, FollowUnfollowState>(
                  listener: (context, state) {
                    if (state is FollowOtherUserSuccess) {
                      displayMsg(context, Colors.blue,
                          ' Successfully followed u/${otherUser!.username}');
                    } else if (state is FollowOtherUserNotSuccess) {
                      displayMsg(context, Colors.red,
                          'An error has occured. please try again later');
                    } else if (state is UnFollowOtherUserSuccess) {
                      displayMsg(context, Colors.blue,
                          ' Successfully unfollowed u/${otherUser!.username}');
                    } else if (state is UnFollowOtherUserNotSuccess) {
                      displayMsg(context, Colors.red,
                          'An error has occured. please try again later');
                    }
                  },
                ),
                BlocListener<MessagesCubit, MessagesState>(
                    listener: (context, state) {
                  if (state is MessageSent) {
                    subjectController.text = '';
                    messageController.text = '';
                    Navigator.pushReplacementNamed(
                        context, otherProfilePageRoute,
                        arguments: otherUser!.username);
                    Navigator.pop(context);
                    displayMsg(
                        context, Colors.green, ' Message is sent successfully');
                  } else if (state is EmptySubject) {
                    displayMsg(context, Colors.red, 'Please enter a subject');
                  } else if (state is EmptyBody) {
                    displayMsg(context, Colors.red, 'Please enter a message');
                  } else {
                    displayMsg(context, Colors.red, 'An error has occured');
                  }
                }),
                BlocListener<UserProfileCubit, UserProfileState>(
                    listener: (context, state) {
                  if (state is UserBlocked) {
                    displayMsg(context, Colors.blue,
                        ' ${otherUser!.username} was blocked');
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  } else if (state is ErrorOccured) {
                    displayMsg(context, Colors.red, 'An error has occured');
                  }
                })
              ],
              child: BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state is UserInfoAvailable) {
                    otherUser = state.userInfo;
                    return _buildBody();
                  }
                  //  else if (state is FollowOtherUserSuccess ||
                  //     state is FollowOtherUserNotSuccess ||
                  //     state is UnFollowOtherUserSuccess ||
                  //     state is UnFollowOtherUserNotSuccess) {
                  //   return _buildBody();
                  // }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )),
      ),
    );
  }
}
