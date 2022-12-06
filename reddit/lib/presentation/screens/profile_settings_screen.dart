import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/model/user_settings.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  ProfileSettings? profileSettings;
  late TextEditingController displayName;
  Map changed = {};
  late TextEditingController about;
  String displayNameTxt = '';
  String aboutTxt = '';
  late bool contentVisibility;
  late bool showActiveCommunities;
  File? imgCover;
  File? imgProfile;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsCubit>(context).getUserSettings();
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
      final imageTemp = File(image.path);

      switch (dest) {
        case 'cover':
          // imgCover = imageTemp;
          BlocProvider.of<SettingsCubit>(context)
              .changeCoverphoto(profileSettings!, imageTemp);
          break;
        case 'profile':
          imgProfile = imageTemp;
          BlocProvider.of<SettingsCubit>(context)
              .changeProfilephoto(profileSettings!, imageTemp);

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

  Widget socialLinks(Widget icon, String lable) {
    return ActionChip(
      backgroundColor: Colors.white,
      label: Text(
        lable,
      ),
      labelStyle: const TextStyle(fontSize: 13, color: Colors.black),
      avatar: icon,
      onPressed: () {},
    );
  }

  void addLinks(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
                leading: const CloseButton(),
                centerTitle: true,
                title: const Text('Add Social Link')),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                children: [
                  socialLinks(Logo(Logos.reddit, size: 15), 'Reddit'),
                  socialLinks(Logo(Logos.facebook_f, size: 15), 'Facebook'),
                  socialLinks(Logo(Logos.whatsapp, size: 15), 'Whatsapp'),
                  socialLinks(Logo(Logos.youtube, size: 15), 'Youtube'),
                  socialLinks(Logo(Logos.instagram, size: 15), 'Instagram'),
                  socialLinks(Logo(Logos.twitter, size: 15), 'Twitter'),
                  socialLinks(Logo(Logos.discord, size: 15), 'Discord'),
                  socialLinks(Logo(Logos.spotify, size: 15), 'Spotify'),
                  socialLinks(Logo(Logos.paypal, size: 15), 'Paypal'),
                  socialLinks(Logo(Logos.twitch, size: 15), 'Twitch'),
                  socialLinks(Logo(Logos.tumblr, size: 15), 'Tumblr'),
                ],
              ),
            ),
          );
        });
  }

  Widget buildEditProfileBody(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(clipBehavior: Clip.none, children: [
            //------------- Change Cover Photo --------------
            InkWell(
              onTap: () => chooseCoverPhotoBottomSheet(ctx),
              child: Container(
                width: MediaQuery.of(ctx).size.width,
                height: 130,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(30, 30, 30, 100),
                ),
                child: (profileSettings!.cover != '')
                    ? Image.network(
                        profileSettings!.cover,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.add_a_photo_outlined),
              ),
            ),
            //------------- Change Profile Photo --------------
            Positioned(
              top: 90,
              left: 20,
              child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: (profileSettings!.profile != '' && imgProfile == null)
                      ? ClipOval(
                          child: InkWell(
                            onTap: () => chooseProfilePhotoBottomSheet(context),
                            child: Image.network(
                              profileSettings!.profile,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              chooseProfilePhotoBottomSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black,
                            ),
                          ))),
            ),
            Positioned(
                top: 140,
                left: 80,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(100, 100, 100, 1),
                  ),
                  child: InkWell(
                    onTap: () => pickImage(ImageSource.gallery, 'profile'),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ))
          ]),
          //---------------------------------------------------
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------- Display Name--------------
                const SizedBox(height: 30),
                const Text('Display name (optional)',
                    style: TextStyle(fontSize: 17)),
                const SizedBox(height: 10),
                TextField(
                    onSubmitted: (value) => changed['displayName'] = value,
                    controller: displayName,
                    maxLength: 30,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)),
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Shown on your profile page',
                    )),
                const Text(
                  'This will be displayed to viewrs of your profile page and does not change your username.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                //---------------- About ----------------
                const SizedBox(height: 30),
                const Text(
                  'About (optional)',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 10),
                TextField(
                    onSubmitted: (value) => changed['about'] = value,
                    controller: about,
                    minLines: 5,
                    maxLines: 20,
                    maxLength: 200,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)),
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'A little description of yourself',
                    )),
                //------------- Social Links --------------
                const SizedBox(height: 30),
                const Text('Social Links (5 Max)',
                    style: TextStyle(fontSize: 17)),
                const SizedBox(height: 10),
                const Text(
                  'Peaple who visit your Reddit profile will see your social links.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => addLinks(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text(
                            " Add",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          //------------- Content Visibility --------------
          const SizedBox(height: 20),

          SwitchListTile(
            key: const Key("allow_people_to_follow_you"),
            activeColor: Colors.blue,
            value: profileSettings!.contentVisibility,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.contentVisibility = newValue;
                contentVisibility = newValue;
                changed['contentVisibility'] = newValue;
              });
            },
            title: const Text('Content visibility',
                style: TextStyle(fontSize: 17)),
            subtitle: const Text(
                '\nPosts to this profile can appear in r/all and your profile can be discovered on r/users',
                style: TextStyle(fontSize: 15, color: Colors.grey)),
          ),
          //------------- Show active Communities --------------
          const SizedBox(height: 20),
          SwitchListTile(
            activeColor: Colors.blue,
            value: profileSettings!.activeInCommunitiesVisibility,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.activeInCommunitiesVisibility = newValue;
                showActiveCommunities = newValue;
                changed['activeInCommunitiesVisibility'] = newValue;
              });
            },
            title: const Text('Show active communities',
                style: TextStyle(fontSize: 17)),
            subtitle: const Text(
                '\nDecide whether to show the coomunities you are active in on your profile.',
                style: TextStyle(fontSize: 15, color: Colors.grey)),
          ),
          const SizedBox(height: 20),
          //----------------------------------------------------
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        centerTitle: true,
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
              onPressed: () {
                if (changed.isNotEmpty) {
                  BlocProvider.of<SettingsCubit>(context)
                      .updateSettings(profileSettings!, changed);
                }
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)))
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(builder: (_, state) {
        if (state is SettingsAvailable) {
          profileSettings = state.settings;
          displayName =
              TextEditingController(text: profileSettings!.displayName);
          about = TextEditingController(text: profileSettings!.about);
          contentVisibility = profileSettings!.contentVisibility;
          showActiveCommunities =
              profileSettings!.activeInCommunitiesVisibility;
          return buildEditProfileBody(context);
        } else if (state is SettingsChanged) {
          profileSettings = state.settings;
          displayName =
              TextEditingController(text: profileSettings!.displayName);
          about = TextEditingController(text: profileSettings!.about);

          return buildEditProfileBody(context);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
