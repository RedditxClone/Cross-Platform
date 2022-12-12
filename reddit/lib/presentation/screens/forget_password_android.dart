import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/strings.dart';
import '../../helper/dio.dart';

class ForgetPasswordAndroid extends StatefulWidget {
  const ForgetPasswordAndroid({super.key});

  @override
  State<ForgetPasswordAndroid> createState() => _ForgetPasswordAndroidState();
}

TextSpan createTextSpan(String txt, bool isUrl, {String url = ""}) {
  return TextSpan(
    text: txt,
    style: TextStyle(
      fontSize: 15,
      color: isUrl ? Colors.red : Colors.grey,
      decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
    ),
    recognizer: TapGestureRecognizer()
      ..onTap = () {
        if (isUrl) {
          launchUrl(Uri.parse(url));
        }
      },
  );
}

class _ForgetPasswordAndroidState extends State<ForgetPasswordAndroid> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  bool emailCorrect = false;
  bool usernameEmpty = true;
  bool emailEmpty = true;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    emailController.text = "";
    usernameController.text = "";
    usernameFocusNode.addListener(_onFocusChangeUsername);
    emailFocusNode.addListener(_onFocusChangeEmail);
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    emailFocusNode.removeListener(_onFocusChangeEmail);
    emailFocusNode.dispose();
  }

  //call back function for username focus node to be called of the focus changes
  void _onFocusChangeUsername() {
    debugPrint("Focus on username: ${usernameFocusNode.hasFocus.toString()}");
  }

  //call back function for email focus node to be called of the focus changes
  void _onFocusChangeEmail() {
    debugPrint("Focus on email: ${emailFocusNode.hasFocus.toString()}");
  }

  void emailMe() {
    BlocProvider.of<AuthCubit>(context).forgetPassword(usernameController.text);
    // await DioHelper.postData(url: "/api/auth/forget_password", data: {
    //   "email": emailController.text,
    //   "username": usernameController.text,
    // }).then((value) {
    //   if (value.statusCode == 201) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Row(
    //           children: [
    //             Logo(
    //               Logos.reddit,
    //               color: Colors.green,
    //               size: 25,
    //             ),
    //             SizedBox(width: MediaQuery.of(context).size.width * 0.01),
    //             const Text("Email sent successfully"),
    //           ],
    //         ),
    //       ),
    //     );
    //     Navigator.of(context).pushReplacementNamed(loginScreen);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text("Your email is not registered"),
    //       ),
    //     );
    //   }
    // });
  }

  Widget mainBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: TextField(
                focusNode: usernameFocusNode,
                controller: usernameController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Username',
                  labelText: 'Username',
                  suffixIcon: usernameEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              usernameController.text = "";
                              usernameEmpty = true;
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          )),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) => setState(() {
                  usernameEmpty = value.isEmpty;
                }),
                onEditingComplete: () {
                  emailFocusNode.requestFocus();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextField(
                focusNode: emailFocusNode,
                controller: emailController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Email',
                  prefixIcon: emailEmpty
                      ? null
                      : emailCorrect
                          ? const Icon(
                              IconData(0xf635, fontFamily: 'MaterialIcons'),
                              color: Colors.green,
                            )
                          : const Icon(
                              IconData(0xf713, fontFamily: 'MaterialIcons'),
                              color: Colors.red,
                            ),
                  suffixIcon: emailEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              emailController.text = "";
                              emailEmpty = true;
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        ),
                ),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    emailEmpty = value.isEmpty;
                    int index = value.indexOf('@');
                    if (index != -1) {
                      emailCorrect = value.contains('.', index + 2) &&
                          value[value.length - 1] != '.' &&
                          value[value.length - 1] != ' ';
                    }
                  });
                },
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  emailMe();
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      createTextSpan(
                          "Unfortunately, if you have never given us your email,\n",
                          false),
                      createTextSpan(
                          "you won't be able to reset your password.", false),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).pushNamed(forgetUsernameAndroid);
                  }),
                  child: const Text(
                    "Forget username?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => launchUrl(
                    Uri.parse(
                        "https://reddit.zendesk.com/hc/en-us/articles/205240005-How-do-I-log-in-to-Reddit-if-I-forgot-my-password-"),
                    mode: LaunchMode.externalApplication,
                  ),
                  child: const Text(
                    "Having trouble?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
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
                onPressed: !usernameEmpty && emailCorrect ? emailMe : null,
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
                    gradient: !usernameEmpty && emailCorrect
                        ? const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 139, 9, 0),
                              Color.fromARGB(255, 255, 136, 0)
                            ],
                          )
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Email me',
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

  @override
  Widget build(BuildContext context) {
    //initialize the textfields to be empty when the bottom sheet is opened
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CircleAvatar(
          backgroundColor: Colors.red,
          child: Logo(
            Logos.reddit,
            color: Colors.white,
            size: 25,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(loginScreen);
            },
            child: const Text(
              "Log in",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        child: mainBody(),
        listener: (context, state) {
          if (state is ForgetPassword) {
            if (state.isSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Logo(
                        Logos.reddit,
                        color: Colors.green,
                        size: 25,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      const Text("Email sent successfully"),
                    ],
                  ),
                ),
              );
              Navigator.of(context).pushReplacementNamed(loginScreen);
            } else {
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
                        'Your email is not registered',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
