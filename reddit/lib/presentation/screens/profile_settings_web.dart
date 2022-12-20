import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/data/model/user_settings.dart';

class ProfileSettingsWeb extends StatefulWidget {
  const ProfileSettingsWeb({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsWeb> createState() => _ProfileSettingsWebState();
}

class _ProfileSettingsWebState extends State<ProfileSettingsWeb> {
  ProfileSettings? profileSettings;
  late Responsive responsive;
  late TextEditingController displayName;
  late TextEditingController about;
  String displayNameTxt = '';
  String aboutTxt = '';
  late bool nsfw = true;
  late bool allowPeopleToFollowYou = true;
  late bool activeInCommunitiesVisibility = true;
  late bool contentVisibility = true;
  late bool showActiveCommunities;

  Uint8List webImgCover = Uint8List(8);
  Uint8List webImgProfile = Uint8List(8);
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SettingsCubit>(context).getUserSettings();
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
              .changeProfilephotoWeb(profileSettings!, imageBytes);
        } else if (dest == 'cover') {
          BlocProvider.of<SettingsCubit>(context)
              .changeCoverphotoWeb(profileSettings!, imageBytes);
        }
        displayMsg(context, Colors.blue, 'Changes Saved');
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());

      displayMsg(context, Colors.red, 'Could not load image');
    }
  }

  Widget addImageButton(double topCorner, double leftCorner) {
    return Positioned(
        top: topCorner,
        left: leftCorner,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            shape: BoxShape.circle,
            color: const Color.fromARGB(186, 7, 7, 7),
          ),
          child: const Icon(
            Icons.add_a_photo_outlined,
            color: Colors.white,
            size: 25,
          ),
        ));
  }

  Widget title(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget buildEditProfileBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cutomize Profile',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          /////////////////---PROFILE INFORMATION--//////////////////////
          const Text('PROFILE INFORMATION',
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Divider(),
          //------------- Display Name--------------
          title('Display name (optional)',
              'Set a display name. This does not change your username.'),
          TextField(
              onEditingComplete: () {
                BlocProvider.of<SettingsCubit>(context).updateSettings(
                    profileSettings!, {'displayName': displayName.text});
                displayMsg(context, Colors.blue, 'Changes Saved');
              },
              controller: displayName,
              maxLength: 30,
              style: const TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Display name (optional)',
              )),
          //------------- About --------------
          title('About (optional)',
              'A brief description of yourself shown on your profile.'),
          TextField(
              onEditingComplete: () {
                BlocProvider.of<SettingsCubit>(context)
                    .updateSettings(profileSettings!, {'about': about.text});
                displayMsg(context, Colors.blue, 'Changes Saved');
              },
              controller: about,
              minLines: 5,
              maxLines: 20,
              maxLength: 200,
              style: const TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'About (optional)',
              )),
          //------------- Social Links --------------
          title('Social links (5 max)',
              'People who visit your profile will see your social links.'),
          SizedBox(
            width: 150,
            height: 40,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(90, 90, 90, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text(
                      " Add social link",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 25),

          /////////////////---IMAGES--//////////////////////
          const Text('IMAGES',
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Divider(),
          const SizedBox(height: 20),
          //------------- Avatar and banner image --------------
          title('Avatar and banner image',
              'Peaple who visit your Reddit profile will see your social links.'),
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: profileSettings!.profile != ''
                        ? GestureDetector(
                            onTap: () =>
                                pickImageWeb(ImageSource.gallery, 'profile'),
                            child: ClipOval(
                              child: Image.network(
                                profileSettings!.profile,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () =>
                                pickImageWeb(ImageSource.gallery, 'profile'),
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
                                size: 80,
                                color: Colors.black,
                              ),
                            )),
                  ),
                  addImageButton(90, 70),
                ],
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => pickImageWeb(ImageSource.gallery, 'cover'),
                child: DottedBorder(
                  dashPattern: const [3, 2],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(5),
                  color: Colors.white,
                  child: Container(
                    width: responsive.isXLargeSizedScreen()
                        ? 425
                        : responsive.isLargeSizedScreen()
                            ? 0.3 * (MediaQuery.of(context).size.width)
                            : responsive.isMediumSizedScreen()
                                ? 0.4 * (MediaQuery.of(context).size.width)
                                : (MediaQuery.of(context).size.width - 160),
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(30, 30, 30, 100),
                    ),
                    //add image here
                    child: (profileSettings!.cover != '')
                        ? Image.network(
                            profileSettings!.cover,
                            fit: BoxFit.fitWidth,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_circle,
                                size: 45,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Drag and Drop or Upload Banner Image',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /////////////////---PROFILE CATEGORY--//////////////////////
          const Text('PROFILE CATEGORY',
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Divider(),

          //------------- NSFW --------------
          SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.all(0),
            value: profileSettings!.nsfw,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.nsfw = newValue;
                nsfw = newValue;
                BlocProvider.of<SettingsCubit>(context)
                    .updateSettings(profileSettings!, {'nsfw': newValue});
                displayMsg(context, Colors.blue, 'Changes Saved');
              });
            },
            title: const Text('NSFW', style: TextStyle(fontSize: 16)),
            subtitle: const Text(
                'This content is NSFW (may contain nudity, pornography, profanity or inappropriate content for those under 18)',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ),
          const SizedBox(height: 20),

          /////////////////---ADVANCED--//////////////////////
          const Text('ADVANCED',
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Divider(),

          //------------- Allow people to follow you --------------
          SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.all(0),
            value: profileSettings!.allowPeopleToFollowYou,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.allowPeopleToFollowYou = newValue;
                allowPeopleToFollowYou = newValue;
                BlocProvider.of<SettingsCubit>(context).updateSettings(
                    profileSettings!, {'allowPeopleToFollowYou': newValue});
                displayMsg(context, Colors.blue, 'Changes Saved');
              });
            },
            title: const Text('Allow people to follow you',
                style: TextStyle(fontSize: 16)),
            subtitle: const Text(
                'Followers will be notified about posts you make to your profile and see them in their home feed.',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ),
          //------------- Content visibility --------------
          SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.all(0),
            value: profileSettings!.contentVisibility,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.contentVisibility = newValue;
                contentVisibility = newValue;
                BlocProvider.of<SettingsCubit>(context).updateSettings(
                    profileSettings!, {'contentVisibility': newValue});
                displayMsg(context, Colors.blue, 'Changes Saved');
              });
            },
            title: const Text('Content visibility',
                style: TextStyle(fontSize: 16)),
            subtitle: const Text(
                'Posts to this profile can appear in r/all and your profile can be discovered in /users',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ),
          //------------- Active in communities visibility --------------
          SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.all(0),
            value: profileSettings!.activeInCommunitiesVisibility,
            onChanged: (newValue) {
              setState(() {
                profileSettings!.activeInCommunitiesVisibility = newValue;
                showActiveCommunities = newValue;
                BlocProvider.of<SettingsCubit>(context).updateSettings(
                    profileSettings!,
                    {'activeInCommunitiesVisibility': newValue});
                displayMsg(context, Colors.blue, 'Changes Saved');
              });
            },
            title: const Text('Active in communities visibility',
                style: TextStyle(fontSize: 16)),
            subtitle: const Text(
                'Show which communities I am active in on my profile.',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ),
          /////////////////---PROFILE MODERATION--//////////////////////
          const Text('PROFILE MODERATION',
              style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (_, state) {
          if (state is SettingsAvailable) {
            responsive = Responsive(context);
            profileSettings = state.settings;
            displayName =
                TextEditingController(text: profileSettings!.displayName);
            about = TextEditingController(text: profileSettings!.about);
            contentVisibility = profileSettings!.contentVisibility;
            showActiveCommunities =
                profileSettings!.activeInCommunitiesVisibility;
            return buildEditProfileBody();
          } else if (state is SettingsChanged) {
            profileSettings = state.settings;
            return buildEditProfileBody();
          } else {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
