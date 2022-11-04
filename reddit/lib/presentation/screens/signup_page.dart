import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../constants/strings.dart';
import '../../data/model/signin.dart';
import '../../data/web_services/authorization/login_conroller.dart';

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
    FacebookSignInApi.facebookInit();
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
      var loginResult = await FacebookSignInApi.login();
      if (loginResult != null) {
        var fbUser = await FacebookSignInApi.getUserData();
        newUser = User(
          name: fbUser['name'] as String,
          email: fbUser['email'] as String,
          imageUrl: fbUser['picture']['data']['url'] as String,
          userId: fbUser['id'] as String,
        );
        Navigator.of(context).pushNamed(
          HOME_PAGE,
          arguments: newUser,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error in Signing in with Facebook"),
          ),
        );
      }
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Text(
                      "By continuing, you are setting up a Reddit",
                      style: textStyleForPolicy,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Row(
                      children: [
                        const Text(
                          "account and agree to our ",
                          style: textStyleForPolicy,
                        ),
                        InkWell(
                          onTap: () => print("click"),
                          child: const Text(
                            "User Agreement",
                            style: textStyleForLinks,
                          ),
                        ),
                        const Text(" and ", style: textStyleForPolicy),
                        InkWell(
                          onTap: () => print("click"),
                          child: const Text(
                            "Privacy Policy",
                            style: textStyleForLinks,
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
                        controller: emailController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          labelText: 'Email',
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
                        onPressed: continieSignUp,
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
                        child: const Text("Continue"),
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
                                .pushNamed(LOGIN_PAGE), //navigate to login page
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
