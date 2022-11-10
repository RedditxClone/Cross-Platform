import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/strings.dart';
import '../../data/model/signin.dart';
import '../../data/web_services/authorization/login_conroller.dart';
import '../../helper/dio.dart';

class SignupWeb extends StatefulWidget {
  const SignupWeb({super.key});

  @override
  State<SignupWeb> createState() => _SignupWebState();
}

class _SignupWebState extends State<SignupWeb> {
  late User newUser;
  var emailController = TextEditingController();
  bool emailCorrect = false;

  @override
  void initState() {
    super.initState();
    FacebookSignInApi.init();
  }

//this finction return a TextSpan
//it takes the text itself
//isUrl : bool to select the required style
//url : the url to be opened if the user pressed the text and isUrl is true
  TextSpan createTextSpan(String txt, bool isUrl, {String url = ""}) {
    return TextSpan(
      text: txt,
      style: TextStyle(
        fontSize: 15,
        color: isUrl ? Colors.blue : Colors.grey,
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

  //this an async fucntion to log in with google account and store the result in database
  Future signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginWeb();
      if (googleAccount != null) {
        DioHelper.postData(url: '/api/auth/signup', data: {
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
              chooseGenderScreen,
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
        DioHelper.postData(url: '/api/auth/signup', data: {
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
              chooseGenderScreen,
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
        // newUser = User(
        //   name: fbUser['name'] as String,
        //   email: fbUser['email'] as String,
        //   imageUrl: fbUser['picture']['data']['url'] as String,
        //   userId: fbUser['id'] as String,
        // );
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

  void continieSignUp() {
    if (emailCorrect) {
      newUser = User(
        name: null,
        email: emailController.text, //set the email takes from the text field
        imageUrl: null,
        userId: null,
      );
      Navigator.of(context).pushNamed(
        SIGNU_PAGE2,
        arguments: newUser,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          createTextSpan(
                              "By continuing, you are setting up a Reddit\n",
                              false),
                          createTextSpan("account and agree to our ", false),
                          createTextSpan("User Agreement ", true,
                              url:
                                  "https://www.redditinc.com/policies/user-agreement"),
                          createTextSpan("\nand ", false),
                          createTextSpan("Privacy Policy.", true,
                              url:
                                  "https://www.reddit.com/policies/privacy-policy"),
                        ],
                      ),
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
                        controller: emailController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          labelText: 'Email',
                          helperText: 'Email',
                          errorText: emailCorrect
                              ? null
                              : 'Please fix your email to continue',
                          suffixIcon: emailController.text.isEmpty
                              ? null
                              : emailCorrect
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
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            int index = value.indexOf('@');
                            if (index != -1) {
                              emailCorrect = value.contains('.', index + 2) &&
                                  value[value.length - 1] != '.' &&
                                  value[value.length - 1] != ' ';
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: emailCorrect ? continieSignUp : null,
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
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already a redditor?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 83, 83),
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(loginPage), //navigate to login page
                            child: const Text(
                              " Log in",
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
