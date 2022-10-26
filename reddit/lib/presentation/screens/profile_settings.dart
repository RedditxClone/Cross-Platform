import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetting {
  bool contentVisibility = true;
  bool showActiveCommunities = true;
  bool isCoverPhotoExist = false;
  File? img;

  Future pickImage(ImageSource src) async {
    try {
      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);
      img = imageTemp;
    } on PlatformException catch (e) {
      print(e);
    }
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
                    onPressed: () => pickImage(ImageSource.camera),
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
                    onPressed: () => pickImage(ImageSource.gallery),
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
                      primary: Color.fromRGBO(90, 90, 90, 100),
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Center(
                      child: Text(
                        " Close",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  void editProfileBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height -
                MediaQuery.of(ctx).padding.top),
        context: ctx,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              leading: const CloseButton(),
              centerTitle: true,
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text('Save', style: TextStyle(fontSize: 20)))
              ],
            ),
            body: SingleChildScrollView(
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
                          child: img != null
                              ? Image.file(
                                  img!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.add_a_photo_outlined)),
                    ),
                    //------------- Change Profile Photo --------------
                    Positioned(
                      top: 90,
                      left: 20,
                      child: ElevatedButton(
                          onPressed: () {
                            //chooseCoverPhotoBottomSheet(ctx);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            child: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          )),
                    ),
                    Positioned(
                        top: 130,
                        left: 70,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                            size: 20,
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  Text(
                                    " Add",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                    activeColor: Colors.blue,
                    value: contentVisibility,
                    onChanged: (newValue) {
                      contentVisibility = newValue;
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
                    value: showActiveCommunities,
                    onChanged: (newValue) {
                      showActiveCommunities = newValue;
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
            ),
          );
        });
  }
}
