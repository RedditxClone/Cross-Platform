import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import '../../constants/strings.dart';
import '../../data/model/auth_model.dart';

class InterestsAndroid extends StatefulWidget {
  const InterestsAndroid({super.key});
  @override
  State<InterestsAndroid> createState() => _InterestsAndroidState();
}

class _InterestsAndroidState extends State<InterestsAndroid> {
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

  //this function is used to add the user interests to the database
  void addInterests() async {
    BlocProvider.of<AuthCubit>(context)
        .addInterests(selectedInterests, UserData.user!.token ?? "");
  }

  Widget mainBody() {
    return Container(
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
                              : Color(
                                  const Color.fromARGB(255, 50, 49, 49).value),
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
                      constraints:
                          const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
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
    );
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
      body: BlocListener<AuthCubit, AuthState>(
        child: mainBody(),
        listener: (context, state) {
          if (state is AddUserInterests) {
            if (state.interestsUpdated) {
              displayMsg(context, Colors.green, 'Data added successfully');
              Navigator.of(context).pushReplacementNamed(
                chooseProfileImgScreen,
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
