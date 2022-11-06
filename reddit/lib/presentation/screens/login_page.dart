import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/helper/dio.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/strings.dart';
import '../../data/model/signin.dart';
import '../../data/web_services/authorization/login_conroller.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  late User newUser;

  final userAgreementUrl = Uri.parse(USER_AGGREMENT);
  final privacyPolicyUrl = Uri.parse(PRIVACY_POLICY);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool loginCorrect = true;
  bool usernameCorrect = true;
  // bool passwordEmpty = false;
  // bool usernameEmpty = false;
  bool usernameUsed = false;
  bool passwordVisible = true;
  @override
  void initState() {
    super.initState();
    // FacebookSignInApi.init();
  }

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget createContinueWithButton(String lable) {
    return OutlinedButton.icon(
      onPressed: lable == 'google' ? signInWithGoogle : signInWithFacebook,
      icon: Logo(
        lable == 'google' ? Logos.google : Logos.facebook_logo,
        size: 20,
      ),
      label: Text("Continue with $lable",
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 20, 72, 114),
            fontWeight: FontWeight.bold,
          )),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(color: Color.fromARGB(255, 9, 51, 85), width: 1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(
          lable == 'google'
              ? const EdgeInsets.fromLTRB(39, 20, 39, 20)
              : const EdgeInsets.fromLTRB(30, 20, 30, 20),
        ),
      ),
    );
  }

  Future signInWithFacebook() async {
    try {
      // var loginResult = await FacebookSignInApi.login();
      // if (loginResult != null) {
      //   var fbUser = await FacebookSignInApi.getUserData();
      //   newUser = User(
      //     name: fbUser['name'] as String,
      //     email: fbUser['email'] as String,
      //     imageUrl: fbUser['picture']['data']['url'] as String,
      //     userId: fbUser['id'] as String,
      //   );
      //   Navigator.of(context).pushNamed(
      //     HOME_PAGE,
      //     arguments: newUser,
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("Error in Signing in with Facebook"),
      //     ),
      //   );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginWeb().then((value) {
        newUser = User(
          name: value?.displayName,
          email: value?.email,
          imageUrl: value?.photoUrl,
          userId: value?.id,
        );
        Navigator.of(context).pushNamed(
          HOME_PAGE,
          arguments: newUser,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error in Signing in with Google"),
        ),
      );
    }
  }

  void continueLogin() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill out the empty fields"),
        ),
      );
    } else {
      if (loginCorrect) {
        DioHelper.postData(url: "/api/auth/login", data: {
          "username": usernameController.text,
          "password": passwordController.text,
        }).then((value) {
          if (value.statusCode == 201) {
            newUser = User.fromJson(value.data);
            Navigator.of(context).pushNamed(HOME_PAGE); //navigate to home page
          } else {
            setState(() {
              loginCorrect = false;
            });
          }
        });
      } else {
        if (!loginCorrect) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Username or Password incorrect"),
            ),
          );
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyleForPolicy = TextStyle(
      fontSize: 12,
      color: Colors.black,
    );
    const textStyleForLinks = TextStyle(
      fontSize: 12,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: null,
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.09,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/sidelogo.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width * 0.4,
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        const Text(
                          "By continuing, you agree to our ",
                          style: textStyleForPolicy,
                        ),
                        Link(
                          uri: userAgreementUrl,
                          target: LinkTarget.blank,
                          builder: (context, followLink) => InkWell(
                            onTap: followLink,
                            child: const Text(
                              "User Agreement",
                              style: textStyleForLinks,
                            ),
                          ),
                        ),
                        const Text(" and ", style: textStyleForPolicy),
                        Link(
                          uri: privacyPolicyUrl,
                          target: LinkTarget.blank,
                          builder: (context, followLink) => InkWell(
                            onTap: followLink,
                            child: const Text(
                              "Privacy Policy.",
                              style: textStyleForLinks,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    createContinueWithButton("google"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    createContinueWithButton("facebook"),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                            ),
                          ),
                          Center(
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Color.fromARGB(255, 85, 83, 83),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "CHOOSE A USERNAME",
                          label: const Text("CHOOSE A USERNAME"),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          prefixIcon: usernameController.text.isEmpty
                              ? null
                              : usernameCorrect
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
                          errorText: usernameController.text.isEmpty ||
                                  usernameCorrect
                              ? null
                              : "Username must be between 3 and 20 characters",
                        ),
                        maxLines: 1,
                        // maxLength: 20,
                        textInputAction: TextInputAction.unspecified,
                        onChanged: (value) {
                          setState(() {
                            usernameCorrect =
                                value.length >= 3 && value.length <= 20;
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "PASSWORD",
                          label: const Text("PASSWORD"),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              passwordVisible = !passwordVisible;
                            }),
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          prefixIcon: passwordController.text.isEmpty
                              ? null
                              : loginCorrect
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
                          errorText:
                              passwordController.text.isEmpty || loginCorrect
                                  ? null
                                  : "Incorrect is password",
                        ),
                        maxLines: 1,
                        obscureText: passwordVisible,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: continueLogin,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 42, 94, 137),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(120, 25, 120, 25),
                          ),
                        ),
                        child: const Text("LOG IN"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Forgot your ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 83, 83),
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                forgetUsername), //navigate to login page
                            child: const Text(
                              "username",
                              style: TextStyle(
                                color: Color.fromARGB(255, 42, 94, 137),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            " or ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 83, 83),
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                forgetPassword), //navigate to login page
                            child: const Text(
                              "password ?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 42, 94, 137),
                                fontSize: 14,
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
          )
        ],
      ),
    );
  }
}
