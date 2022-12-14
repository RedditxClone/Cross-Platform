import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/end_drawer/end_drawer_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

import '../../../business_logic/cubit/create_community_cubit.dart';
import '../../../data/repository/create_community_repository.dart';
import '../../../data/web_services/create_community_web_services.dart';
import '../../screens/create_community_screen.dart';

/// Class that build the UI of the homepage end drawer
class EndDrawer extends StatelessWidget {
  late final int _karma;
  late final int _redditAge;
  File? imgProfile;
  EndDrawer(this._karma, this._redditAge, {Key? key}) : super(key: key);

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

  /// Build the UI of the end drawer when the user is logged in
  Widget _buildLoggedInEndDrawer(context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfilePicture(context),
              _buildUsernameButton(context),
              //_buildOnlineStatus(),
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
            ],
          ),
          _buildKarmaAndRedditAge(),
          _buildScrollViewButtons(context),
          _buildSettingsButton(context),
        ],
      ),
    );
  }

  /// Build the UI of the end drawer when the user is logged out
  Widget _buildLoggedOutEndDrawer(context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.person_pin,
                size: 100,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Sign up to upvote the best content, customize your feed, share your interests, and more!",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Sign up / Log in"),
                  onTap: () {
                    // TODO: go to sign up / log in page
                    Navigator.pushNamed(context, loginScreen);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    // TODO: this may be changed by another settings page
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the UI of the profile picture, only when user is logged in
  Widget _buildProfilePicture(context) {
    return BlocBuilder<EndDrawerCubit, EndDrawerState>(
      builder: (context, state) {
        if (state is EndDrawerProfilePictureChanged) {
          return GestureDetector(
            onTap: () {
              chooseProfilePhotoBottomSheet(context);
            },
            child: CircleAvatar(
              radius: 120.0,
              backgroundImage: NetworkImage(state.url),
              backgroundColor: Colors.transparent,
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            chooseProfilePhotoBottomSheet(context);
          },
          child: UserData.profileSettings!.profile == ""
              ? const Icon(
                  Icons.person_pin,
                  size: 240,
                )
              : CircleAvatar(
                  radius: 120.0,
                  backgroundImage:
                      NetworkImage(UserData.profileSettings!.profile),
                  backgroundColor: Colors.transparent,
                ),
        );
      },
    );
  }

  /// Build the bottom settings button of the drawer
  Widget _buildSettingsButton(context) {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("Settings"),
      onTap: () {
        // TODO: this may be changed by another settings page
        // Navigator.of(context).pop();
        Navigator.of(context).pushNamed(accountSettingsRoute, arguments: {
          "username": UserData.user!.username,
          "email": UserData.user!.email,
          "gender": UserData.accountSettings!.gender == 'male', //_isMan
        });
      },
    );
  }

  /// Build the scroll view buttons of the drawer
  Widget _buildScrollViewButtons(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("My profile"),
                onTap: () => Navigator.of(context).pushNamed(profilePageRoute),
              ),
              ListTile(
                  leading: const FaIcon(FontAwesomeIcons.plus),
                  title: const Text("Create a community"),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider(
                            create: (context) => CreateCommunityCubit(
                                CreateCommunityRepository(
                                    CreateCommunityWebServices())),
                            child: const CreateCommunityScreen(),
                          )))),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.bookmark),
                title: const Text("Saved"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.clock),
                title: const Text("History"),
                onTap: () =>
                    Navigator.of(context).pushNamed(historyPageScreenRoute),
              ),
              ListTile(
                leading: const Icon(Icons.paste_outlined),
                title: const Text("Pending posts"),
                onTap: () {},
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.fileLines),
                title: const Text("Drafts"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the UI of Karma and Reddit age of the drawer
  Widget _buildKarmaAndRedditAge() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: const FaIcon(
                    FontAwesomeIcons.dharmachakra,
                    color: Colors.blue,
                  ),
                  title: Text("$_karma"),
                  subtitle: const Text("Karma"),
                ),
              ),
              VerticalDivider(
                color: Colors.grey.shade600,
              ),
              Expanded(
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: const FaIcon(
                    FontAwesomeIcons.cakeCandles,
                    color: Colors.blue,
                  ),
                  title: Text("$_redditAge d"),
                  subtitle: const Text("Reddit age"),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade600,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  /// Build the UI of the online status bar in the drawer,
  /// It is UI only (no functionality)
  Widget _buildOnlineStatus() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SizedBox(
        width: 150,
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.circle,
                color: Colors.green,
                size: 15,
              ),
            ),
            Text(
              "Online Status: On",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the UI of the username button
  Widget _buildUsernameButton(context) {
    return TextButton(
      onPressed: () => _accountsBottomSheet(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "u/${UserData.user!.username}",
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_outlined)
        ],
      ),
    );
  }

  /// Opens bottom sheet to see the selected account and log out
  void _accountsBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.98,
      ),
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 0),
                child: Text("ACCOUNTS"),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("u/${UserData.user!.username}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        // Logout bottomsheet
                        Navigator.of(context).pop();
                        _logOutBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  // TODO: Add account function
                },
                leading: const Icon(Icons.add),
                title: const Text("Add account"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade800,
                  ),
                  child: const Text(
                    "CLOSE",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// Opens the log out bottom sheet
  void _logOutBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.98,
      ),
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                child: Text("U/${UserData.user!.username.toUpperCase()}"),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  UserData.logout();
                  Navigator.of(context).pushReplacementNamed(homePageRoute);
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade800,
                  ),
                  child: const Text(
                    "CLOSE",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// Pick the image when changing profile picture
  Future pickImage(ImageSource src, context) async {
    try {
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);

      imgProfile = imageTemp;
      BlocProvider.of<EndDrawerCubit>(context).changeProfilephoto(imageTemp);
    } on PlatformException catch (e) {
      displayMsg(context, Colors.red, 'Error', 'Could not load image');
    }
  }

  /// Opens bottom sheet to select the destination of the photo (Camera, Library)
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
                  onPressed: () => pickImage(ImageSource.camera, ctx),
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
                  onPressed: () => pickImage(ImageSource.gallery, ctx),
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
                    primary: const Color.fromRGBO(90, 90, 90, 100),
                    onPrimary: Colors.grey,
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
      },
    );
  }

  /// Display message when the profile photo is changed successfully
  void displayMsg(
      BuildContext context, Color color, String title, String subtitle) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 70,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 7,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, color: color),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: color),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
