// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/constants/strings.dart';
import '../../data/model/auth_model.dart';

class ChooseProfileImgAndroid extends StatefulWidget {
  const ChooseProfileImgAndroid({super.key});
  @override
  State<ChooseProfileImgAndroid> createState() =>
      ChooseProfileImgAndroidState();
}

class ChooseProfileImgAndroidState extends State<ChooseProfileImgAndroid> {
  File? imgCover;

  //this function to display the image if selected and if not it will show a static icon
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
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

//this function to create the bottom sheet resposible to choose the image
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

//this function to get the image from the gallery or take it by the camera
  Future pickImage(ImageSource src, String dest) async {
    try {
      Navigator.pop(context);
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);
      BlocProvider.of<AuthCubit>(context).changeProfilephotoMob(imageTemp);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      displayMsg(context, Colors.red, 'Error', 'Could not load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          backgroundColor: Colors.red,
          child: Logo(
            Logos.reddit,
            color: Colors.white,
            size: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (() {
              Navigator.of(context).pushReplacementNamed(homePageRoute);
            }),
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Choose your profile photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "This how people will see you on Reddit.\n",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: "(You can change it later if you'd like)",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                    if (state is ChooseProfileImageLoginChanged) {
                      UserData.profileSettings!.profile = state.url;
                      return ClipOval(
                        child: InkWell(
                          onTap: () => chooseProfilePhotoBottomSheet(context),
                          child: Image.network(
                            UserData.profileSettings!.profile,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                          onPressed: () =>
                              chooseProfilePhotoBottomSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black,
                            ),
                          ));
                    }
                  }),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ElevatedButton(
                onPressed: () {
                  if (UserData.profileSettings!.profile != '') {
                    Navigator.of(context).pushReplacementNamed(
                      homePageRoute,
                    );
                  }
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
                        const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Save and Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
