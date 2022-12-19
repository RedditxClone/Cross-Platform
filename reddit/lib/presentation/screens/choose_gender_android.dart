import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/constants/strings.dart';
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
    BlocProvider.of<AuthCubit>(context)
        .genderInSignup(UserData.user!.token, gender);
    //     url: 'user/me/prefs',
    //     data: {
    //       "gender": gender,
    //     },
    //     options: Options(
    //       headers: {
    //         "Authorization":
    //             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzN2ZlNjM4NWUwYjU4M2Y0YTc5ZTM0ZiIsImlhdCI6MTY2OTkwNjQyMiwiZXhwIjoxNjcwNzcwNDIyfQ.Jukdcxvc1j8i78uNshWkPPpBBwh9mMFRoQT6hGgLrY4"
    //       },
    //     )).then((res) {
    //   res = res as Response;
    //   if (res.statusCode == 200) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Row(
    //           children: const [
    //             Icon(
    //               Icons.reddit,
    //               color: Colors.green,
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(
    //               'Data add successfully',
    //               style: TextStyle(
    //                 color: Colors.black,
    //                 backgroundColor: Colors.white,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //     Navigator.of(context).pushReplacementNamed(
    //       interesetesScreen,
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Row(
    //           children: const [
    //             Icon(
    //               Icons.error,
    //               color: Colors.red,
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(
    //               'Error in storing your data please try again',
    //               style: TextStyle(
    //                 color: Colors.red,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   }
    // });
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

  Widget mainBody() {
    return Container(
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
    );
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
              Navigator.of(context).pushReplacementNamed(interesetesScreen);
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
      body: BlocListener<AuthCubit, AuthState>(
        child: mainBody(),
        listener: (context, state) {
          if (state is UpdateGenderDuringSignup) {
            if (state.genderUpdated) {
              displayMsg(context, Colors.green, 'Data added successfully');

              Navigator.of(context).pushReplacementNamed(
                interesetesScreen,
              );
            } else {
              displayMsg(context, Colors.red,
                  'Error in storing your data please try again');
            }
          }
        },
      ),
    );
  }
}
