import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class OtherProfilePageWeb extends StatefulWidget {
  late User otherUser;
  OtherProfilePageWeb({required this.otherUser, super.key});

  @override
  State<OtherProfilePageWeb> createState() => _OtherProfilePageWebState();
}

class _OtherProfilePageWebState extends State<OtherProfilePageWeb> {
  late Responsive _responsive;
  String sortBy = 'new';
  bool _isOverviewTab = true;
  bool _isFollowed = false;

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

  Widget _sortBy() {
    return Container(
      // sort posts
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by new
                  setState(() {
                    sortBy = 'new';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'new'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sortBy == 'new'
                        ? const Icon(Icons.new_releases_sharp)
                        : const Icon(Icons.new_releases_outlined),
                    const SizedBox(width: 5),
                    const Text(
                      'New',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by hot
                  setState(() {
                    sortBy = 'hot';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'hot'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sortBy == 'hot'
                        ? const Icon(Icons.local_fire_department)
                        : const Icon(Icons.local_fire_department_outlined),
                    const SizedBox(width: 5),
                    const Text(
                      'Hot',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  // TODO : sort by top
                  setState(() {
                    sortBy = 'top';
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: sortBy == 'top'
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.trending_up_rounded),
                    SizedBox(width: 5),
                    Text(
                      'Top',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _follow() {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<UserProfileCubit>(context).follow(
            "638f9e7d31186b7fd21bae89"); // TODO :  change this to the id of the other user
      },
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
        padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
          alignment: Alignment.center,
          child: const Text(
            'Follow',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _unfollow() {
    return OutlinedButton(
      onPressed: () => BlocProvider.of<UserProfileCubit>(context)
          .unfollow("638f9e7d31186b7fd21bae89"),
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          side: const BorderSide(width: 1, color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      child: const Text(
        "Unfollow",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(height: 100, color: Colors.blue),
                  Container(height: 100, color: Colors.transparent),
                ],
              ),
              //---------------Other profile picture------------------
              CircleAvatar(
                  radius: 60,
                  child: widget.otherUser.profilePic == null ||
                          widget.otherUser.profilePic == ''
                      ? const Icon(Icons.person, size: 50)
                      : Image.network(widget.otherUser.profilePic!,
                          fit: BoxFit.cover)),
            ],
          ),
          Text(widget.otherUser.displayName,
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Text('u/${widget.otherUser.name} . 26m',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 20),
          //--------------------karma and cake day-------------
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Karma',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.blue,
                        size: 10,
                      ),
                      SizedBox(width: 5),
                      Text('10,532', // TODO : add karma number here
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  )
                ]),
                SizedBox(
                    width: MediaQuery.of(context).size.width < 1600 &&
                            MediaQuery.of(context).size.width >= 1100
                        ? 60
                        : MediaQuery.of(context).size.width < 1100 &&
                                MediaQuery.of(context).size.width >= 900
                            ? 70
                            : 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cake day',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Icon(
                          Icons.cake,
                          color: Colors.blue,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text('September 4, 2018', // TODO : add cake day here
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          //--------------------Follow - Chat----------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    width: 165,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    child: BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        if (state is FollowOtherUserSuccess) {
                          return _unfollow();
                        } else if (state is UnFollowOtherUserSuccess) {
                          return _follow();
                        }
                        return _follow();
                      },
                    )),
              ),
              Expanded(
                child: Container(
                  width: 165,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {}, // TODO : navigate to chat
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 70.0, minHeight: 20.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Chat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Container(
      color: defaultWebBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: _responsive.isSmallSizedScreen() ||
                              _responsive.isMediumSizedScreen()
                          ? 0
                          : _responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: const SizedBox(width: 0)),
                  Expanded(
                    flex: _responsive.isLargeSizedScreen()
                        ? 7
                        : _responsive.isXLargeSizedScreen()
                            ? 5
                            : 7,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: 10,
                      child: Column(
                        children: [
                          _sortBy(),
                          const PostsWeb(),
                          const PostsWeb(),
                          const PostsWeb(),
                          const PostsWeb(),
                        ],
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width < 900
                      ? const SizedBox(width: 0)
                      : Expanded(
                          flex: _responsive.isLargeSizedScreen() ||
                                  _responsive.isMediumSizedScreen()
                              ? 3
                              : 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: _buildProfileCard(),
                          )),
                  Expanded(
                      flex: _responsive.isSmallSizedScreen() ||
                              _responsive.isMediumSizedScreen()
                          ? 0
                          : _responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: SizedBox(
                          width: _responsive.isMediumSizedScreen() ? 15 : 0))
                ],
              ),
            ),
          )
        ],
      ),
      //),
    );
  }

  Widget _myposts() {
    // TODO : continue this function
    return Container(
      padding: const EdgeInsets.all(5),
      height: 120,
      color: defaultSecondaryColor,
      child: Row(
        children: [
          Container(
            color: defaultSecondaryColor.withOpacity(0.001),
            child: Column(
              children: const [
                SizedBox(height: 10),
                Icon(Icons.arrow_upward, color: Colors.grey),
                SizedBox(height: 10),
                Text("0", style: TextStyle(fontSize: 13)),
                SizedBox(height: 10),
                Icon(Icons.arrow_downward, color: Colors.grey),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Here is a post label',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Text('r/redditx_'),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(children: const [
                      Icon(Icons.mode_comment_outlined, color: Colors.grey),
                      SizedBox(width: 5),
                      Text("0", style: TextStyle(fontSize: 13)),
                    ]),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPosts() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: MediaQuery.of(context).size.width < 1000
                  ? const EdgeInsets.only(right: 0)
                  : const EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width < 1000
                  ? MediaQuery.of(context).size.width - 40
                  : MediaQuery.of(context).size.width - 380,
              child: Column(
                children: [
                  _sortBy(),
                  // TODO : add user posts here
                  _myposts(),
                ],
              ),
            ),
            MediaQuery.of(context).size.width < 1000
                ? const SizedBox(width: 0)
                : Column(
                    children: [
                      Container(
                        width: 320,
                        height: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: defaultSecondaryColor),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: _buildProfileCard(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        _buildOverview(),
        _buildPosts(),
        _buildPosts(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title:
              AppBarWebLoggedIn(user: UserData.user!, screen: 'u/user_name')),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: defaultAppbarBackgroundColor,
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5)),
            bottom: TabBar(
              onTap: (index) {
                setState(() {
                  _isOverviewTab = index == 0 ? true : false;
                });
              },
              padding: _isOverviewTab
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3 > 300
                          ? MediaQuery.of(context).size.width * 0.3
                          : MediaQuery.of(context).size.width * 0.2 > 100 &&
                                  MediaQuery.of(context).size.width * 0.3 <= 300
                              ? MediaQuery.of(context).size.width * 0.05
                              : 5)
                  : EdgeInsets.fromLTRB(
                      5,
                      0,
                      MediaQuery.of(context).size.width * 0.5 > 300
                          ? MediaQuery.of(context).size.width * 0.5
                          : MediaQuery.of(context).size.width * 0.3 > 100 &&
                                  MediaQuery.of(context).size.width * 0.5 <= 300
                              ? MediaQuery.of(context).size.width * 0.05
                              : 5,
                      0),
              indicatorColor: Colors.white,
              tabs: const [
                Tab(icon: Text('OVERVIEW', style: TextStyle(fontSize: 13))),
                Tab(icon: Text('POSTS', style: TextStyle(fontSize: 13))),
                Tab(icon: Text('COMMENTS', style: TextStyle(fontSize: 13))),
              ],
            ),
          ),
          body: BlocListener<UserProfileCubit, UserProfileState>(
              listener: (context, state) {
                if (state is FollowOtherUserSuccess) {
                  displayMsg(context, Colors.blue,
                      ' Successfully followed u/${widget.otherUser.name}');
                } else if (state is FollowOtherUserNotSuccess) {
                  displayMsg(context, Colors.red,
                      'An error has occured. please try again later');
                } else if (state is UnFollowOtherUserSuccess) {
                  displayMsg(context, Colors.blue,
                      ' Successfully unfollowed u/${widget.otherUser.name}');
                } else if (state is UnFollowOtherUserNotSuccess) {
                  displayMsg(context, Colors.red,
                      'An error has occured. please try again later');
                }
              },
              child: _buildBody()),
        ),
      ),
    );
  }
}
