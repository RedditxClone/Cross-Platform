import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/helper/dio.dart';

import '../../data/model/auth_model.dart';

class ChooseGenderAndroid extends StatefulWidget {
  const ChooseGenderAndroid({super.key});
  @override
  State<ChooseGenderAndroid> createState() => _ChooseGenderAndroidState();
}

class _ChooseGenderAndroidState extends State<ChooseGenderAndroid> {
  var buttonColor1 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor2 = const Color.fromARGB(255, 58, 57, 57);
  bool choosed = false;

  //This function takes the selected gender and sends it to the server
  //gender will be null if not selected
  void selectGender(String gender) async {
    UserData.user?.gender = gender;
    DioHelper.patchData(
        url: 'user/me/prefs',
        data: {
          "gender": gender,
        },
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzN2ZlNjM4NWUwYjU4M2Y0YTc5ZTM0ZiIsImlhdCI6MTY2OTkwNjQyMiwiZXhwIjoxNjcwNzcwNDIyfQ.Jukdcxvc1j8i78uNshWkPPpBBwh9mMFRoQT6hGgLrY4"
          },
        )).then((res) {
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
                setState(() {
                  if (!choosed) {
                    buttonColor1 == const Color.fromARGB(255, 82, 46, 46)
                        ? null
                        : selectGender("male");
                    buttonColor1 = const Color.fromARGB(255, 82, 46, 46);
                    choosed = true;
                  }
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
                setState(() {
                  if (!choosed) {
                    buttonColor2 == const Color.fromARGB(255, 82, 46, 46)
                        ? null
                        : selectGender("woman");
                    buttonColor2 = const Color.fromARGB(255, 82, 46, 46);
                    choosed = true;
                  }
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
          ],
        ),
      ),
    );
  }
}
