import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import '../../data/model/signin.dart';
import '../../helper/dio.dart';

class SignupWeb2 extends StatefulWidget {
  const SignupWeb2({super.key, required this.user});
  final User user;
  @override
  State<SignupWeb2> createState() => _SignupWeb2State(user);
}

class _SignupWeb2State extends State<SignupWeb2> {
  late User user;
  _SignupWeb2State(this.user);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordCorrect = false;
  bool usernameUsed = false;
  bool passwordVisible = true;
  bool usernameLengthError = false;
  bool passwordLengthError = false;
  bool usernameEmpty = true;
  bool passwordEmpty = true;
  bool redundantUsername = false;
  bool usernameError = false;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  Map<String, dynamic> suggestedUsernames = {};
  @override
  void initState() {
    super.initState();
    usernameController.text = "";
    passwordController.text = "";
    usernameFocusNode.addListener(_onFocusChangeUsername);
    passwordFocusNode.addListener(_onFocusChangePassword);
    getSuggestedUsernames();
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    passwordFocusNode.removeListener(_onFocusChangePassword);
    passwordFocusNode.dispose();
  }

  //call back function for username focus node to be called of the focus changes
  void _onFocusChangeUsername() {
    debugPrint("Focus on username: ${usernameFocusNode.hasFocus.toString()}");
    if (!usernameFocusNode.hasFocus) {
      checkOnUsername(usernameController.text);
    }
  }

  //call back function for password focus node to be called of the focus changes
  void _onFocusChangePassword() {
    debugPrint("Focus on password: ${passwordFocusNode.hasFocus.toString()}");
  }

//function takes the username and checks if it is valid or not
  //this fucntion is called if the user pressed next after typing the username or if the focus is lost from the username field
  void checkOnUsername(String usrName) async {
    await DioHelper.postData(url: '/api/user/check-available-username', data: {
      'username': usrName,
    }).then((value) {
      setState(() {
        if (value.statusCode == 200) {
          redundantUsername = false;
          debugPrint("Username is available");
        } else {
          redundantUsername = true;
        }
      });
    });
  }

  //function to sign up with reddit accound it's called when the user presses the sign up button or if the user pressed done after typing the password
  void signUpContinue(BuildContext ctx) async {
    await DioHelper.postData(url: '/api/auth/signup', data: {
      "password": passwordController.text,
      "name": usernameController.text,
      "email": user.email,
    }).then((value) {
      if (value.statusCode == 201) {
        user = User.fromJson(jsonDecode(value.data));
        Navigator.of(ctx).pushReplacementNamed(
          homePageRoute,
          arguments: user,
        );
      } else {
        print(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const Text(
                  'Username or password is incorrect',
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

  Future getSuggestedUsernames() async {
    await DioHelper.getData(url: "/api/auth/suggested_usernames", query: {})
        .then((value) {
      if (value.statusCode == 200) {
        suggestedUsernames = jsonDecode(value.data);
      } else {
        debugPrint("Error getting suggested usernames");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
        child: AppBar(
          title: Container(
            padding: const EdgeInsets.fromLTRB(30, 40, 0, 30),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Choose your username\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Your username is how other community members will see you. This name will be used to credit you for things you share on Reddit. What should we call you?",
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      // backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData.light(),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          TextField(
                            focusNode: usernameFocusNode,
                            controller: usernameController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Username',
                              labelText: 'Username',
                              errorText: usernameEmpty
                                  ? null
                                  : usernameError
                                      ? "Username can only contain letters, numbers,'-' and '_'"
                                      : usernameLengthError
                                          ? "Username must be between 3 and 20 characters"
                                          : null,
                              suffixIcon: usernameEmpty &&
                                      !usernameFocusNode.hasFocus
                                  ? null
                                  : !usernameEmpty && usernameFocusNode.hasFocus
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              usernameController.text = "";
                                              usernameEmpty = true;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.grey,
                                          ),
                                        )
                                      : !usernameFocusNode.hasFocus &&
                                              !usernameLengthError &&
                                              !usernameError &&
                                              !usernameEmpty &&
                                              !redundantUsername
                                          ? const Icon(
                                              IconData(0xf635,
                                                  fontFamily: 'MaterialIcons'),
                                              color: Colors.green,
                                            )
                                          : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                usernameEmpty = value.isEmpty;
                                usernameError =
                                    value.contains(RegExp(r'[^a-zA-Z0-9_-]'));
                                usernameLengthError =
                                    value.length < 3 || value.length > 20;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              checkOnUsername(usernameController.text);
                              passwordFocusNode.requestFocus();
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          TextField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            style: const TextStyle(fontSize: 18),
                            obscureText: passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  passwordVisible = !passwordVisible;
                                }),
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              prefixIcon: passwordEmpty
                                  ? null
                                  : passwordCorrect && !passwordLengthError
                                      ? const Icon(
                                          IconData(0xf635,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          IconData(0xf713,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.red,
                                        ),
                              hintText: 'Password',
                              labelText: 'Password',
                              errorText: passwordEmpty
                                  ? null
                                  : !passwordCorrect
                                      ? "Password cannot contain your username"
                                      : passwordLengthError
                                          ? "Password must be at least 8 characters"
                                          : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                passwordLengthError = value.length < 8;
                                passwordEmpty = value.isEmpty;
                                passwordCorrect =
                                    !value.contains(usernameController.text);
                              });
                            },
                            textInputAction: TextInputAction.done,
                            onEditingComplete: !usernameFocusNode.hasFocus &&
                                    !usernameLengthError &&
                                    !usernameError &&
                                    !usernameEmpty &&
                                    !redundantUsername
                                ? () => signUpContinue(context)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                  SIGNU_PAGE1,
                                ); //navigate to SIGN UP 1 page
                              },
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // TODO : solve this condition (peter)
                                // !usernameLengthError &&
                                //         !passwordLengthError &&
                                //         passwordCorrect &&
                                //         !passwordEmpty &&
                                //         !usernameError &&
                                //         !usernameEmpty &&
                                //         !redundantUsername
                                //? () =>

                                signUpContinue(context);
                                //: null;
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(50, 18, 50, 18),
                                ),
                              ),
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        setState(() {
                          getSuggestedUsernames();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Here are some username suggestions")),
                  ...suggestedUsernames.entries.map((e) {
                    return Text(e.value);
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
