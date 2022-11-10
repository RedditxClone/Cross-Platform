import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/strings.dart';
import '../../data/model/signin.dart';
import '../../helper/dio.dart';

//for testing and will be deleted
class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Home> createState() => _HomeState(user);
}

class _HomeState extends State<Home> {
  final User user;
  _HomeState(this.user);

  Map<String, String> interests = {
    "Funny": '🤣',
    "Jokes": '😂',
    "Interesting": '🤔',
    'Memes': '💩',
    'Lifehacks': '💡',
    'Nature': '🌿',
    'History': '📜',
    'Tech': '📱',
    'Science': '🔬',
    'News': '📰',
    'Career': '👔',
    'Books': '📚',
    'Programming': '👨‍💻',
    'Sports': '⚽',
    'space': '🚀',
    'Travel': '✈',
    'Fishing': '🎣',
  };
  Map<String, dynamic> selectedInterests = {};
  File? imgCover;

  //this function is used to add the user interests to the database
  void addInterests() async {
    user.interests = selectedInterests;
    debugPrint("after storing${user.interests}");
    DioHelper.patchData(url: '/api/user/me/prefs', data: selectedInterests)
        .then((value) {
      if (value.statusCode == 200) {
        Navigator.of(context).pop();
        showDialogToChooseProfilePicture();
      } else {
        SnackBar(
          content: Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Error in storing your data please try again',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  //This function takes the selected gender and sends it to the server
  //gender will be null if not selected
  void selectGender(String gender) async {
    user.gender = gender;
    await DioHelper.patchData(url: "/api/user/me/prefs", data: {
      "gender": gender,
    }).then((res) {
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.reddit,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Data add successfully',
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
        Navigator.of(context).pop();
        showDialogToChooseInterests();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Error in storing your data please try again',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

//this fucntion to choose the gender of the user and send to the server
  void showDialogToChooseGender() {
    var buttonColor1 = const Color.fromARGB(255, 237, 237, 237);
    var buttonColor2 = const Color.fromARGB(255, 237, 237, 237);
    var buttonColor3 = const Color.fromARGB(255, 237, 237, 237);
    var buttonColor4 = const Color.fromARGB(255, 237, 237, 237);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            icon: const Icon(
              Icons.reddit,
              size: 40,
            ),
            iconColor: Colors.red,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialogToChooseInterests();
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            title: const Text(
              "About you",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Tell us about yourself to start building your home feed",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "I'm a...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          buttonColor1 == const Color.fromARGB(255, 82, 46, 46)
                              ? null
                              : selectGender("Man");
                          buttonColor1 = const Color.fromARGB(255, 82, 46, 46);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor: buttonColor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: buttonColor1 ==
                                    const Color.fromARGB(255, 82, 46, 46)
                                ? Colors.red
                                : buttonColor1,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Man",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        buttonColor2 == const Color.fromARGB(255, 82, 46, 46)
                            ? null
                            : selectGender("Woman");
                        setState(() {
                          buttonColor2 = const Color.fromARGB(255, 82, 46, 46);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor: buttonColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: buttonColor2 ==
                                    const Color.fromARGB(255, 82, 46, 46)
                                ? Colors.red
                                : buttonColor2,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Woman",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        buttonColor3 == const Color.fromARGB(255, 82, 46, 46)
                            ? null
                            : selectGender("Non-binary");
                        setState(() {
                          buttonColor3 = const Color.fromARGB(255, 82, 46, 46);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor: buttonColor3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: buttonColor3 ==
                                    const Color.fromARGB(255, 82, 46, 46)
                                ? Colors.red
                                : buttonColor3,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Non-binary",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        buttonColor4 == const Color.fromARGB(255, 82, 46, 46)
                            ? null
                            : selectGender("I prefer not to say");
                        setState(() {
                          buttonColor4 = const Color.fromARGB(255, 82, 46, 46);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor: buttonColor4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: buttonColor4 ==
                                    const Color.fromARGB(255, 82, 46, 46)
                                ? Colors.red
                                : buttonColor4,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "I prefer not to say",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int intersetsCount = 0;
//This function will show the dialog to choose interests
  void showDialogToChooseInterests() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            icon: AppBar(
              elevation: 0,
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                  showDialogToChooseGender();
                },
              ),
              backgroundColor: Colors.white,
              title: CircleAvatar(
                backgroundColor: Colors.red,
                child: Logo(
                  Logos.reddit,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              centerTitle: true,
            ),
            title: const Text(
              "Interests",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.25,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    "Pick things you'd like to see in your home feed",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 2,
                            runSpacing: 2,
                            children: [
                              ...interests.entries.map((e) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: selectedInterests.containsKey(e.key)
                                        ? const BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          )
                                        : BorderSide.none,
                                  ),
                                  color: selectedInterests.containsKey(e.key)
                                      ? const Color.fromARGB(255, 82, 46, 46)
                                      : Color(const Color.fromARGB(
                                              255, 237, 237, 237)
                                          .value),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                    child: TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (!selectedInterests
                                              .containsKey(e.key)) {
                                            selectedInterests.addEntries([
                                              e
                                            ]); //add the selected interest to the map
                                            intersetsCount++;
                                          } else {
                                            intersetsCount--;
                                            selectedInterests.remove(e.key);
                                          }
                                          debugPrint("count = $intersetsCount");
                                        });
                                        debugPrint(
                                            selectedInterests.toString());
                                      },
                                      icon: Text(
                                        e.value,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      label: Text(
                                        e.key,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        padding: const EdgeInsets.all(15),
                        color: Theme.of(context).dialogBackgroundColor,
                        child: ElevatedButton(
                          onPressed: intersetsCount >= 3 ? addInterests : null,
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: intersetsCount >= 3
                                  ? const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 139, 9, 0),
                                        Color.fromARGB(255, 255, 136, 0)
                                      ],
                                    )
                                  : const LinearGradient(
                                      colors: [
                                        Color.fromARGB(50, 139, 9, 0),
                                        Color.fromARGB(50, 255, 136, 0)
                                      ],
                                    ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: intersetsCount < 3
                                  ? Text(
                                      '$intersetsCount of 3 Selected',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : const Text(
                                      'Continue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showDialogToChooseProfilePicture() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            icon: AppBar(
              elevation: 0,
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                  showDialogToChooseInterests();
                },
              ),
              actions: [
                TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed(
                      homePageRoute,
                      arguments: user,
                    );
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
              backgroundColor: Colors.white,
              title: CircleAvatar(
                backgroundColor: Colors.red,
                child: Logo(
                  Logos.reddit,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              centerTitle: true,
            ),
            title: const Text(
              'Choose your profile photo',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "This how people will see you on Reddit.\n",
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: imgCover != null
                            ? ClipOval(
                                child: InkWell(
                                  onTap: () =>
                                      chooseProfilePhotoBottomSheet(context),
                                  child: Image.file(
                                    imgCover!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : ElevatedButton(
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
                                ),
                              ),
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
                        // newUser.imageUrl = imgCover!.readAsString() as String?;
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacementNamed(
                          homePageRoute,
                          arguments: user,
                        );
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
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 50.0),
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
          ),
        );
      },
    );
  }

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
        });
  }

//this function to get the image from the gallery or take it by the camera
  Future pickImage(ImageSource src, String dest) async {
    try {
      Navigator.pop(context);

      final image = await ImagePicker().pickImage(source: src);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        imgCover = imageTemp;
      });
    } on PlatformException catch (e) {
      displayMsg(context, Colors.red, 'Error', 'Could not load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            // CircleAvatar(
            //   backgroundImage:
            //       user.imageUrl != null ? NetworkImage(user.imageUrl!) : null,
            //   radius: 100,
            // ),
            Text(
              user.name != null ? user.name! : "null",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.userId != null ? user.userId! : "null",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.email != null ? user.email! : "null",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // var res = await GoogleSingInApi.signoutWeb();
                // if (res == null) {
                //   Navigator.of(context).pushReplacementNamed('/');
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Error in Signing in with Google"),
                //     ),
                //   );
                // }
                // FacebookSignInApi.logout();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text("Sign Out"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialogToChooseGender();
              },
              child: const Text("Show User Info"),
            ),
          ],
        ),
      ),
    );
  }
}
