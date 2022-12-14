import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/posts/posts_my_profile_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class ProfilePageWeb extends StatefulWidget {
  const ProfilePageWeb({super.key});

  @override
  State<ProfilePageWeb> createState() => _ProfilePageWebState();
}

class _ProfilePageWebState extends State<ProfilePageWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsMyProfileCubit>(context).getMyProfilePosts();
  }

  late Responsive _responsive;
  String _outlineButtonLabel = 'Joined';
  String sortBy = 'new';
  bool _isOverviewTab = true;
  Widget socialLinks(Widget icon, String lable) {
    return ActionChip(
      backgroundColor: const Color.fromARGB(255, 76, 76, 76),
      label: Text(
        lable,
      ),
      labelPadding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
      labelStyle: const TextStyle(fontSize: 13, color: Colors.white),
      avatar: icon,
      onPressed: () {},
    );
  }

  void _addSocialLinks() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: defaultSecondaryColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    const Text('Add Social Link'),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
              ],
            ),
            content: Container(
              width: 420,
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  socialLinks(Logo(Logos.reddit, size: 15), 'Reddit'),
                  socialLinks(Logo(Logos.twitter, size: 15), 'Twitter'),
                  socialLinks(Logo(Logos.tumblr, size: 15), 'Tumblr'),
                  socialLinks(Logo(Logos.youtube, size: 15), 'Youtube'),
                  socialLinks(Logo(Logos.whatsapp, size: 15), 'Whatsapp'),
                  socialLinks(Logo(Logos.facebook_f, size: 15), 'Facebook'),
                  socialLinks(Logo(Logos.instagram, size: 15), 'Instagram'),
                  socialLinks(Logo(Logos.discord, size: 15), 'Discord'),
                  socialLinks(Logo(Logos.spotify, size: 15), 'Spotify'),
                  socialLinks(Logo(Logos.paypal, size: 15), 'Paypal'),
                  socialLinks(Logo(Logos.twitch, size: 15), 'Twitch'),
                ],
              ),
            ),
          );
        });
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

  Widget _buildProfileCard() {
    return Column(
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
            //---------------choose profile/cover picture and settings------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                    radius: 60,
                    child: UserData.user!.profilePic == null ||
                            UserData.user!.profilePic == ''
                        ? const Icon(
                            // TODO : display profile picture here
                            Icons.person,
                            size: 50,
                          )
                        : Image.network(UserData.user!.profilePic!,
                            fit: BoxFit.cover)),
                const SizedBox(width: 60),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black,
                        child: IconButton(
                            onPressed: () {}, // TODO : change cover photo here
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 19,
                            )),
                      ),
                    ),
                    IconButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(settingsTabsRoute),
                        icon: const Icon(Icons.settings)),
                  ],
                )
              ],
            ),
          ],
        ),
        Text(
            UserData.user!.displayName == ''
                ? UserData.user!.username
                : UserData.user!.displayName!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        Text('u/${UserData.user!.username} . 1m',
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        //------------change profile picture button----------
        Container(
          width: double.infinity,
          height: 65,
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {}, // TODO : change profile photo here
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
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 139, 9, 0),
                    Color.fromARGB(255, 255, 136, 0)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
                alignment: Alignment.center,
                child: const Text(
                  'Change your profile picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ),
        //--------------------karma and cake day-------------
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Text('1', // TODO : add karma number here
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  )
                ],
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width < 1420 &&
                          MediaQuery.of(context).size.width >= 1290
                      ? 80
                      : MediaQuery.of(context).size.width < 1030 &&
                              MediaQuery.of(context).size.width >= 1000
                          ? 80
                          : 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cake day',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(
                        Icons.cake,
                        color: Colors.blue,
                        size: 10,
                      ),
                      SizedBox(width: 5),
                      Text('October 4, 2022', // TODO : add cake day here
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        //----------------add social links button------------
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 180,
              height: 40,
              child: ElevatedButton(
                  onPressed: () =>
                      _addSocialLinks(), // TODO : add social links here
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 77, 77, 77),
                    backgroundColor: const Color.fromARGB(255, 116, 116, 116),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        " Add social links",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  )),
            ),
          ],
        ),
        //--------------------add new post--------------------
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {}, // TODO : navigate to add new post
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
                constraints:
                    const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
                alignment: Alignment.center,
                child: const Text(
                  'New Post',
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
      ],
    );
  }

  Widget _buildSecondProflieCard() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              'You\'re a moderator of these communiteise',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----------------------my moderator communities----------------------------
              Row(
                children: [
                  const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 15,
                      )),
                  const SizedBox(width: 10),
                  Column(
                    children: const [
                      Text('r/redditsx_'),
                      SizedBox(height: 5),
                      Text('4 members'),
                    ],
                  )
                ],
              ),
              OutlinedButton(
                  onHover: ((value) {
                    setState(() {
                      _outlineButtonLabel = value ? 'Leave' : 'Joined';
                    });
                  }),
                  onPressed: () {}, // TODO : on press => leave subreddit
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Text(
                    _outlineButtonLabel,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )
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
                      child:
                          BlocBuilder<PostsMyProfileCubit, PostsMyProfileState>(
                        builder: (context, state) {
                          if (state is PostsLoaded) {
                            return Column(children: [
                              ...state.posts!
                                  .map((e) => PostsWeb(postsModel: e))
                                  .toList()
                            ]);
                          }
                          return Container();
                        },
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
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: defaultSecondaryColor),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: _buildProfileCard(),
                                ),
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: defaultSecondaryColor),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: _buildSecondProflieCard(),
                                ),
                              ],
                            ),
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
                      Container(
                        width: 320,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: defaultSecondaryColor),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: _buildSecondProflieCard(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
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
          title: const AppBarWebLoggedIn(screen: 'u/user_name')),
      body: DefaultTabController(
        length: 8,
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
                      horizontal: MediaQuery.of(context).size.width * 0.25 > 300
                          ? MediaQuery.of(context).size.width * 0.22
                          : MediaQuery.of(context).size.width * 0.1 > 100 &&
                                  MediaQuery.of(context).size.width * 0.25 <=
                                      300
                              ? MediaQuery.of(context).size.width * 0.05
                              : 5)
                  : EdgeInsets.fromLTRB(
                      5,
                      0,
                      MediaQuery.of(context).size.width * 0.33 > 300
                          ? MediaQuery.of(context).size.width * 0.33
                          : MediaQuery.of(context).size.width * 0.2 > 100 &&
                                  MediaQuery.of(context).size.width * 0.33 <=
                                      300
                              ? MediaQuery.of(context).size.width * 0.05
                              : 5,
                      0),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Text('OVERVIEW',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('POSTS',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('COMMENTS',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('HISTORY',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('SAVED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('HIDDEN',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('UPVOTED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('DOWNVOTED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 8 : 13))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildOverview(),
              _buildPosts(),
              _buildPosts(),
              _buildPosts(),
              _buildPosts(),
              _buildPosts(),
              _buildPosts(),
              _buildPosts(),
            ],
          ),
        ),
      ),
    );
  }
}
