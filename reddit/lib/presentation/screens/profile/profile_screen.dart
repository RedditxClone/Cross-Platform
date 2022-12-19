import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reddit/business_logic/cubit/posts/posts_my_profile_cubit.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

import '../../widgets/posts/posts_web.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsMyProfileCubit>(context).getMyProfilePosts();
  }

  /// [src] : source of the image can be(camera or gallery).
  /// [dest] : destionation of the image can be 'cover' to change the cover photo or 'profile' to change the profile photo.
  ///
  /// calls the `changeCoverphoto` or `changeProfilephoto` methods inside [SettingsCubit] that Emits sate SettingsChanged on successfully updating photo.
  ///
  /// This function might throw an exception if the user does not allow the app to access the gallery or camera and an error message will be displayed.
  Future pickImage(ImageSource src, String dest) async {
    try {
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      switch (dest) {
        case 'cover':
          BlocProvider.of<SettingsCubit>(context)
              .changeCoverphoto(UserData.profileSettings!, image.path);
          break;
        case 'profile':
          BlocProvider.of<SettingsCubit>(context)
              .changeProfilephoto(UserData.profileSettings!, image.path);

          break;
        default:
          break;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void chooseProfilePhotoBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            height: 170,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                    onPressed: () => pickImage(ImageSource.camera, 'profile'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Camera",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    )),
                TextButton(
                    onPressed: () => pickImage(ImageSource.gallery, 'profile'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Library",
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

  void chooseCoverPhotoBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            height: 170,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                    onPressed: () => pickImage(ImageSource.camera, 'cover'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Camera",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery, 'cover');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Library",
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

  Widget _appBarContent() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        // cover photo
        InkWell(
          onTap: () => chooseCoverPhotoBottomSheet(context),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.redAccent, Colors.black])),
            child: UserData.user!.coverPhoto != ""
                ? BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      if (state is SettingsChanged) {
                        UserData.user!.coverPhoto = state.settings.cover;
                        return Image.network(UserData.user!.coverPhoto,
                            fit: BoxFit.cover);
                      }
                      return Image.network(UserData.user!.coverPhoto,
                          fit: BoxFit.cover);
                    },
                  )
                : null,
          ),
        ),
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
                  InkWell(
                    onTap: () => chooseProfilePhotoBottomSheet(context),
                    child: UserData.user!.profilePic == ''
                        ? const Icon(
                            Icons.person,
                            size: 50,
                          )
                        : BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, state) {
                              if (state is SettingsChanged) {
                                UserData.user!.profilePic =
                                    state.settings.profile;
                                return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      UserData.user!.profilePic!,
                                    ));
                              }
                              return CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    UserData.user!.profilePic!,
                                  ));
                            },
                          ),
                  ),
                  SizedBox(
                    width: 60,
                    child: OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(profileSettingsRoute),
                        style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                  UserData.user!.displayName == ''
                      ? UserData.user!.username
                      : UserData.user!.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 10),
              Text(
                  'u/${UserData.user!.username} . 1 karma . 41d .  ${DateFormat('dd MMM yyyy').format(DateTime.parse(UserData.user!.createdAt!))}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 5),
              Text(UserData.profileSettings!.about,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 60),
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
            UserData.user!.profilePic == ''
                ? const CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      UserData.user!.profilePic!,
                    )),
            const SizedBox(width: 10),
            Text(
              UserData.user!.displayName == ''
                  ? UserData.user!.username
                  : UserData.user!.displayName!,
            ),
          ],
        ),
        Row(
          children: [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.file_upload_outlined, size: 30)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_horiz, size: 30)),
          ],
        ),
      ],
    );
  }

  Widget _buildPosts() {
    return SingleChildScrollView(
      child: BlocBuilder<PostsMyProfileCubit, PostsMyProfileState>(
        builder: (context, state) {
          if (state is PostsLoaded) {
            if (state.posts!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: _empty(),
              );
            }
            return Column(children: [
              ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
            ]);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 100),
            child: _empty(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        _buildPosts(),
        _empty(),
        _empty(),
      ],
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
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsChanged) {
                      return _buildAppBar();
                    }
                    return _buildAppBar();
                  },
                )
              ];
            },
            body: _buildBody()),
      ),
    );
  }
}
