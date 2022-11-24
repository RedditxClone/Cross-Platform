import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/helper/dio.dart';

import '../../data/model/signin.dart';

class ChooseGenderAndroid extends StatefulWidget {
  const ChooseGenderAndroid({super.key, required this.newUser});
  final User newUser;
  @override
  State<ChooseGenderAndroid> createState() =>
      _ChooseGenderAndroidState(newUser);
}

class _ChooseGenderAndroidState extends State<ChooseGenderAndroid> {
  var buttonColor1 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor2 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor3 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor4 = const Color.fromARGB(255, 58, 57, 57);
  late User newUser;

  _ChooseGenderAndroidState(this.newUser);

  //This function takes the selected gender and sends it to the server
  //gender will be null if not selected
  void selectGender(String gender) async {
    newUser.gender = gender;
    await DioHelper.patchData(url: "/api/user/me/prefs", data: {
      "gender": gender,
    },options: null).then((res) {
      res = res as Response;
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
        Navigator.of(context).pushReplacementNamed(
          interesetesScreen,
          arguments: newUser,
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              homePageRoute,
              arguments: newUser,
            );
          },
        ),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "About you",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Tell us about yourself to start building your home feed",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
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
            ElevatedButton(
              onPressed: () {
                buttonColor1 == const Color.fromARGB(255, 82, 46, 46)
                    ? null
                    : selectGender("Man");
                setState(() {
                  buttonColor1 = const Color.fromARGB(255, 82, 46, 46);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: buttonColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: buttonColor1 == const Color.fromARGB(255, 82, 46, 46)
                        ? Colors.red
                        : buttonColor1,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Man",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                selectGender("Woman");
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
                    color: buttonColor2 == const Color.fromARGB(255, 82, 46, 46)
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
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                selectGender("Non-binary");
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
                    color: buttonColor3 == const Color.fromARGB(255, 82, 46, 46)
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
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                selectGender("I prefer not to say");
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
                    color: buttonColor4 == const Color.fromARGB(255, 82, 46, 46)
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
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
