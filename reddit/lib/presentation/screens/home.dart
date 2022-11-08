import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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
  var buttonColor1 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor2 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor3 = const Color.fromARGB(255, 58, 57, 57);
  var buttonColor4 = const Color.fromARGB(255, 58, 57, 57);
  _HomeState(this.user);

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
        Navigator.of(context).pushReplacementNamed(
          interesetesScreen,
          arguments: user,
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

  void showDialogTogetUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.reddit,
            size: 40,
          ),
          iconColor: Colors.red,
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.of(context)
                    .pushReplacementNamed(HOME_PAGE, arguments: user);
              }),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
          content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.3,
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
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
                        color: buttonColor1 ==
                                const Color.fromARGB(255, 82, 46, 46)
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
      },
    );
  }

  void initState() {
    super.initState();
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialogTogetUserInfo();
              },
              child: const Text("Show User Info"),
            ),
          ],
        ),
      ),
    );
  }
}
