import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/model/user_settings.dart';

class ProfileSettingsWeb extends StatefulWidget {
  const ProfileSettingsWeb({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsWeb> createState() => _ProfileSettingsWebState();
}

class _ProfileSettingsWebState extends State<ProfileSettingsWeb> {
  // bool nsfw = true;
  // bool allowPeopleToFollowYou = true;
  // bool activeInCommunitiesVisibility = true;
  // bool contentVisibility = true;
  bool isThereImageCover = false;
  bool isThereImageProfile = false;
  late Settings profileSettings;
  Uint8List webImgCover = Uint8List(8);
  Uint8List webImgProfile = Uint8List(8);
  @override
  void initState() {
    super.initState();
    profileSettings = BlocProvider.of<SettingsCubit>(context).getUserSettings();
  }

  /// ## Parameters
  /// ### src : the image source can be ImageSource.gallery or ImageSource.camera
  /// ### dest : the image destination can be 'cover' for cover photo or 'profile' fom profile photo
  Future pickImage(ImageSource src, String dest) async {
    try {
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final f = await image.readAsBytes();
      setState(() {
        if (dest == 'profile') {
          webImgProfile = f;
          isThereImageProfile = true;
        } else if (dest == 'cover') {
          webImgCover = f;
          isThereImageCover = true;
        }
      });
    } on PlatformException catch (e) {}
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(170, 20, 670, 20),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (_, state) {
              if (state is SettingsAvailable) {
                profileSettings = state.settings;

                return Column(
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
                        maxLength: 30,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Display name (optional)',
                        )),
                    //------------- About --------------
                    title('About (optional)',
                        'A brief description of yourself shown on your profile.'),
                    TextField(
                        minLines: 5,
                        maxLines: 20,
                        maxLength: 200,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
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
                            primary: const Color.fromRGBO(90, 90, 90, 100),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              Text(
                                " Add social link",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
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
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: (profileSettings.profile != '' &&
                                      !isThereImageProfile)
                                  ? GestureDetector(
                                      onTap: () => pickImage(
                                          ImageSource.gallery, 'profile'),
                                      child: ClipOval(
                                        child: Image.network(
                                          profileSettings.profile,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : isThereImageProfile
                                      ? GestureDetector(
                                          onTap: () => pickImage(
                                              ImageSource.gallery, 'profile'),
                                          child: ClipOval(
                                            child: Image.memory(
                                              webImgProfile,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () => pickImage(
                                              ImageSource.gallery, 'profile'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        80.0)),
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
                          onTap: () => pickImage(ImageSource.gallery, 'cover'),
                          child: DottedBorder(
                            dashPattern: const [3, 2],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            color: Colors.white,
                            child: Container(
                              width: 430, //to be changed when responsive
                              height: 120,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(30, 30, 30, 100),
                              ),
                              //add image here
                              child: (profileSettings.cover != '' &&
                                      !isThereImageCover)
                                  ? Image.network(
                                      profileSettings.cover,
                                      fit: BoxFit.cover,
                                    )
                                  : isThereImageCover
                                      ? Image.memory(
                                          webImgCover,
                                          fit: BoxFit.cover,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.add_circle,
                                              size: 45,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Drag and Drop or Upload Banner Image',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white),
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
                      value: profileSettings.nsfw,
                      onChanged: (newValue) {
                        setState(() {
                          profileSettings.nsfw = newValue;
                        });
                      },
                      title: const Text('NSFW', style: TextStyle(fontSize: 16)),
                      subtitle: const Text(
                          'This content is NSFW (may contain nudity, pornography, profanity or inappropriate content for those under 18)',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ),
                    const SizedBox(height: 20),

                    /////////////////---PROFILE CATEGORY--//////////////////////
                    const Text('ADVANCED',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const Divider(),

                    //------------- Allow people to follow you --------------
                    SwitchListTile(
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      value: profileSettings.allowPeopleToFollowYou,
                      onChanged: (newValue) {
                        setState(() {
                          profileSettings.allowPeopleToFollowYou = newValue;
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
                      value: profileSettings.contentVisibility,
                      onChanged: (newValue) {
                        setState(() {
                          profileSettings.contentVisibility = newValue;
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
                      value: profileSettings.activeInCommunitiesVisibility,
                      onChanged: (newValue) {
                        setState(() {
                          profileSettings.activeInCommunitiesVisibility =
                              newValue;
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
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
