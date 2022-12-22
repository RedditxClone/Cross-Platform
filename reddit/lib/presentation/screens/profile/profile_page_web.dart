import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reddit/business_logic/cubit/posts/posts_my_profile_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/sort_cubit.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
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
    BlocProvider.of<UserProfileCubit>(context).getMyModeratedSubreddits();
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

  /// [src] : source of the image can be (camera or gallery).
  /// [dest] : destionation of the image can be 'cover' to change the cover photo or 'profile' to change the profile photo.
  ///
  /// calls the `changeProfilephotoWeb` or `changeProfilephotoWeb` methods inside [SettingsCubit] that Emits sate SettingsChanged on successfully updating photo.
  ///
  /// This function might throw an exception if the user does not allow the app to access the gallery or camera.
  Future pickImageWeb(ImageSource src, String dest) async {
    try {
      final imagePicker = await ImagePicker().pickImage(source: src);
      if (imagePicker == null) return;
      Uint8List imageBytes = await imagePicker.readAsBytes();
      setState(() {
        if (dest == 'profile') {
          BlocProvider.of<SettingsCubit>(context)
              .changeProfilephotoWeb(UserData.profileSettings!, imageBytes);
        } else if (dest == 'cover') {
          BlocProvider.of<SettingsCubit>(context)
              .changeCoverphotoWeb(UserData.profileSettings!, imageBytes);
        }
        displayMsg(context, Colors.blue, 'Changes Saved');
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      displayMsg(context, Colors.red, 'Could not load image');
    }
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
    return BlocBuilder<SortCubit, SortState>(
      builder: (context, state) {
        if (state is SortBest) {
          sortBy = 'best';
          BlocProvider.of<PostsMyProfileCubit>(context)
              .getMyProfilePosts(sort: sortBy);
        } else if (state is SortNew) {
          sortBy = 'new';
          BlocProvider.of<PostsMyProfileCubit>(context)
              .getMyProfilePosts(sort: sortBy);
        } else if (state is SortHot) {
          sortBy = 'hot';
          BlocProvider.of<PostsMyProfileCubit>(context)
              .getMyProfilePosts(sort: sortBy);
        } else if (state is SortTop) {
          sortBy = 'top';
          BlocProvider.of<PostsMyProfileCubit>(context)
              .getMyProfilePosts(sort: sortBy);
        }
        return Container(
          // sort posts
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: defaultSecondaryColor),
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SortCubit>(context).sort("new");
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
                      BlocProvider.of<SortCubit>(context).sort("hot");
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
                      BlocProvider.of<SortCubit>(context).sort("top");
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
      },
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
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return UserData.user!.profilePic == null ||
                            UserData.user!.profilePic == ''
                        ? const CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              UserData.user!.profilePic!,
                            ));
                  },
                ),
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
                            onPressed: () =>
                                pickImageWeb(ImageSource.gallery, 'profile'),
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
                ? UserData.user!.username??""
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
            onPressed: () => pickImageWeb(ImageSource.gallery, 'profile'),
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
                  style: TextStyle(fontSize: 15),
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
                      Text('1',
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
                          : 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cake day',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.cake,
                        color: Colors.blue,
                        size: 10,
                      ),
                      const SizedBox(width: 5),
                      Text(
                          DateFormat.yMMMMd('en_US').format(
                              DateTime.parse(UserData.user!.createdAt!)),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey)),
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
                  onPressed: () => _addSocialLinks(),
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
          height: 51,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {}, // TODO : navigate to add new post
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Colors.white.withOpacity(0.5)),
              shape: const MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(0.0)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
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

  Widget _modSubreddit(String subredditName, members, subredditId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //----------------------my moderator communities----------------------------
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.group_outlined,
                    size: 25,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'r/$subredditName',
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text('$members members'),
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
            onPressed: () => BlocProvider.of<UserProfileCubit>(context)
                .leaveSubreddit(
                    subredditId), // TODO : on press => leave subreddit
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
              'You\'re a moderator of these communities',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is MyModSubredditsAvailable) {
                state.modSubreddits;

                return Column(
                  children: state.modSubreddits.map(
                    (e) {
                      return _modSubreddit(e.name!, 1, e.sId);
                    },
                  ).toList(),
                );
              }
              return Container();
            },
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
                          _myposts(),
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
    return BlocBuilder<PostsMyProfileCubit, PostsMyProfileState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
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
    );
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
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('POSTS',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('COMMENTS',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('HISTORY',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('SAVED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('HIDDEN',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('UPVOTED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 7 : 12))),
                Tab(
                    icon: Text('DOWNVOTED',
                        style: TextStyle(
                            fontSize:
                                _responsive.isSmallSizedScreen() ? 6 : 11))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildOverview(),
              _buildPosts(),
              _indicateEmpty("Create a comment",
                  "No comments are available yet. Create a comment now!"),
              _indicateEmpty(
                  "Open or vote a post", "No history available yet."),
              _indicateEmpty("Save a post",
                  "No saved posts are available yet. Save a post now!"),
              _indicateEmpty(
                  "Hide a post", "No posts are hidden. Hide a post now!"),
              _indicateEmpty("Up vote a post",
                  "No posts are up voted. Up vote a post now!"),
              _indicateEmpty("Down vote a post",
                  "No posts are down voted. Down vote a post now!"),
            ],
          ),
        ),
      ),
    );
  }
}
