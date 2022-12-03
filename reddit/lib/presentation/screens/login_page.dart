// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/helper/dio.dart';
import 'package:url_launcher/link.dart';

import '../../constants/strings.dart';
import '../../data/model/auth_model.dart';
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
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool loginCorrect = true;
  bool usernameCorrect = true;
  bool passwordEmpty = false;
  bool passwordVisible = true;
  final textStyleForPolicy = const TextStyle(
    fontSize: 12,
    color: Colors.black,
  );
  final textStyleForLinks = const TextStyle(
    fontSize: 12,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  @override
  void initState() {
    super.initState();
    FacebookSignInApi.init();
    usernameFocusNode.addListener(_onFocusChangeUsername);
    passwordFocusNode.addListener(_onFocusChangePassword);
    usernameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    passwordFocusNode.removeListener(_onFocusChangePassword);
    passwordFocusNode.dispose();
  }

  void _onFocusChangeUsername() {
    debugPrint("Focus on username: ${usernameFocusNode.hasFocus.toString()}");
  }

  //call back function for password focus node to be called of the focus changes
  void _onFocusChangePassword() {
    debugPrint("Focus on password: ${passwordFocusNode.hasFocus.toString()}");
  }

  //this an async fucntion to log in with google account and store the result in database
  Future signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginWeb();
      if (googleAccount != null) {
        DioHelper.postData(url: 'auth/signup', data: {
          "userId": googleAccount.id,
          "email": googleAccount.email,
          "name": googleAccount.displayName,
          "imageUrl": googleAccount.photoUrl,
          "_type": "google",
          "serverAuthCode": googleAccount.serverAuthCode,
        }).then((value) {
          if (value.statusCode == 201) {
            newUser = User.fromJson(jsonDecode(value.data));
            Navigator.of(context).pushReplacementNamed(
              homePageRoute,
              arguments: newUser,
            );
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
                      "Error in Signing in with Google",
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
                  "Error in Signing in with Google",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
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
                "Error in Signing in with Google",
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

//this an async fucntion to log in with facebook account and store the result in database
  Future signInWithFacebook() async {
    try {
      var loginResult = await FacebookSignInApi.login();
      if (loginResult != null) {
        var fbUser = await FacebookSignInApi
            .getUserData(); //post request to add user data
        DioHelper.postData(url: 'auth/signup', data: {
          "name": fbUser['name'] as String,
          "email": fbUser['email'] as String,
          "imageUrl": fbUser['picture']['data']['url'] as String,
          "userId": loginResult.accessToken?.userId,
          "_type": "facebook",
          "accessToken": loginResult.accessToken?.token,
        }).then((value) {
          if (value.statusCode == 201) {
            newUser = User.fromJson(jsonDecode(value.data));
            Navigator.of(context).pushReplacementNamed(
              homePageRoute,
              arguments: newUser,
            );
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
                      "Error in Signing in with Facebook",
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
    } catch (e) {
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
                "Error in Signing in with Facebook",
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

//This function creates buttonns for login with google and facebook
//it takes a string that determines the function of the button depends on the passed value
//is it for google or facebook
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
          const BorderSide(
            color: Color.fromARGB(255, 9, 51, 85),
            width: 1,
          ),
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

  void continueLogin() {
    if (loginCorrect) {
      // DioHelper.postData(url: "/api/auth/login", data: {
      //   "username": usernameController.text,
      //   "password": passwordController.text,
      // }).then((value) {
      //   if (value.statusCode == 201) {
      //     newUser = User.fromJson(jsonDecode(value.data));
      //     Navigator.of(context).pushReplacementNamed(homePageRoute,
      //         arguments: newUser); //navigate to home page
      //   } else {
      //     setState(() {
      //       loginCorrect = false;
      //     });
      //   }
      // });
      BlocProvider.of<AuthCubit>(context)
          .login(passwordController.text, usernameController.text);
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

  Widget mainBody() {
    return Theme(
      data: ThemeData.light(),
      child: SingleChildScrollView(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.09,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/sidelogo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Wrap(
                          children: [
                            Text(
                              "By continuing, you agree to our ",
                              style: textStyleForPolicy,
                            ),
                            Link(
                              uri: userAgreementUrl,
                              target: LinkTarget.blank,
                              builder: (context, followLink) => InkWell(
                                onTap: followLink,
                                child: Text(
                                  "User Agreement",
                                  style: textStyleForLinks,
                                ),
                              ),
                            ),
                            Text(" and ", style: textStyleForPolicy),
                            Link(
                              uri: privacyPolicyUrl,
                              target: LinkTarget.blank,
                              builder: (context, followLink) => InkWell(
                                onTap: followLink,
                                child: Text(
                                  "Privacy Policy.",
                                  style: textStyleForLinks,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    createContinueWithButton("google"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    createContinueWithButton("facebook"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                              color: Colors.grey,
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
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: usernameController,
                          focusNode: usernameFocusNode,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "CHOOSE A USERNAME",
                            label: const Text("CHOOSE A USERNAME"),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
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
                                : "Username must be between 3 & 20 characters",
                          ),
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              usernameCorrect =
                                  value.length >= 3 && value.length <= 20;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            passwordFocusNode.requestFocus();
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "PASSWORD",
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            label: const Text("PASSWORD"),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
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
                                    : "Passwrod or usernmae is incorrect",
                          ),
                          maxLines: 1,
                          obscureText: passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => setState(() {
                            passwordEmpty = value.isEmpty;
                          }),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            continueLogin();
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: 270,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: usernameCorrect && !passwordEmpty
                              ? continueLogin
                              : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 42, 94, 137),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            // padding: MaterialStateProperty.all(
                            //   const EdgeInsets.fromLTRB(120, 25, 120, 25),
                            // ),
                          ),
                          child: const Text("LOG IN"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                                forgetUsernameWeb), //navigate to login page
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
                                forgetPasswordWeb), //navigate to login page
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        children: [
                          const Text(
                            "New to Reddit? ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 83, 83),
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                SIGNU_PAGE1), //navigate to login page
                            child: const Text(
                              "SIGN UP",
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
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: BlocListener<AuthCubit, AuthState>(
        child: mainBody(),
        listener: (context, state) {
          if (state is Login) {
            if (state.user != null) {
              UserData.initUser(state.user); //this couldn't be null
              Navigator.of(context).pushReplacementNamed(
                homePageRoute,
              );
            } else {
              //user = null
              setState(() {
                loginCorrect = false;
              });
              debugPrint("failed in login");
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
          }
        },
      ),
    );
  }
}
