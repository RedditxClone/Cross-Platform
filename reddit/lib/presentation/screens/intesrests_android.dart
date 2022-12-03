import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/helper/dio.dart';
import '../../constants/strings.dart';
import '../../data/model/auth_model.dart';

class InteresetesAndroid extends StatefulWidget {
  const InteresetesAndroid({super.key});
  @override
  State<InteresetesAndroid> createState() => _InteresetesAndroidState();
}

class _InteresetesAndroidState extends State<InteresetesAndroid> {
  int intersetsCount = 0;

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

  //this function is used to add the user interests to the database
  void addInterests() async {
    UserData.user?.interests = selectedInterests;
    DioHelper.patchData(
        url: 'user/me/prefs',
        data: selectedInterests,
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzN2ZlNjM4NWUwYjU4M2Y0YTc5ZTM0ZiIsImlhdCI6MTY2OTkwNjQyMiwiZXhwIjoxNjcwNzcwNDIyfQ.Jukdcxvc1j8i78uNshWkPPpBBwh9mMFRoQT6hGgLrY4"
          },
        )).then((value) {
      if (value.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(chooseProfileImgScreen);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              chooseGenderScreen,
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
        // actions: [
        //   TextButton(
        //     onPressed: (() {
        //       Navigator.of(context).pushReplacementNamed(HOME_PAGE);
        //     }),
        //     child: const Text(
        //       "Skip",
        //       style: TextStyle(
        //         color: Colors.grey,
        //         fontSize: 20,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Interests",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Pick things you'd like to see in your home feed",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                                : Color(const Color.fromARGB(255, 50, 49, 49)
                                    .value),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    if (!selectedInterests.containsKey(e.key)) {
                                      selectedInterests.addEntries([
                                        e
                                      ]); //add the selected interest to the map
                                      intersetsCount++;
                                    } else {
                                      intersetsCount--;
                                      selectedInterests.remove(e.key);
                                    }
                                  });
                                  debugPrint(selectedInterests.toString());
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
                                    color: Colors.white,
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
                  // color: Theme.of(context).scaffoldBackgroundColor,

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
                      padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
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
    );
  }
}
