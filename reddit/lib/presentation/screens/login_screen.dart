import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/data/model/signin.dart';
import 'package:reddit/presentation/screens/signup_screen.dart';
import '../../constants/strings.dart';
import '../../data/web_services/authorization/login_conroller.dart';
import '../../helper/dio.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  bool passwordVisible = true;
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  // bool usernameError = false;
  bool emailCorrect = false;
  bool passwordCorrect = true;
  bool redundantUsername = false;
  late User newUser;
  @override
  void initState() {
    super.initState();
    // FacebookSignInApi.init();
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  // void checkOnUsername(value) async {
  //   try {
  //     var res = await DioHelper.getData(url: '/api/user/usernamecheck', query: {
  //       'username': value,
  //     }) as Response;
  //     var resData = res.data as Map<String, dynamic>;
  //     print(resData.runtimeType);
  //     if (value.length < 3 || resData['state'] as bool == false) {
  //       print(resData['state']);
  //       setState(() {
  //         redundantUsername = true;
  //       });
  //     } else {
  //       setState(() {
  //         redundantUsername = false;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void loginContinue(BuildContext ctx) async {
    if (emailCorrect && passwordCorrect) {
      await DioHelper.postData(url: '/api/auth/login', data: {
        "email": emailController.text,
        "password": passwordController.text,
        "name": usernameController.text,
      }).then((value) {
        if (value.statusCode == 201) {
          print(value.data);
          newUser = User.fromJson(jsonDecode(value.data));
          Navigator.of(ctx).pop();
          Navigator.of(ctx).pushReplacementNamed(
            HOME_PAGE,
            arguments: newUser,
          );
        } else {
          setState(() {
            // usernameError = true;check if the user name is unique
          });
        }
      });
    }
  }

  TextSpan createTextSpan(String txt, bool isUrl) {
    return TextSpan(
      text: txt,
      style: TextStyle(
        fontSize: 14,
        color: isUrl ? Colors.blue : Colors.grey,
        decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  Future signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginMob();
      if (googleAccount != null) {
        newUser = User(
          userId: googleAccount.id,
          email: googleAccount.email,
          name: googleAccount.displayName ?? '',
          imageUrl: googleAccount.photoUrl ?? '',
        );
        Navigator.of(context).pushNamed(
          HOME_PAGE,
          arguments: newUser,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error in Signing in with Google"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error in Signing in with Google"),
        ),
      );
    }
  }

  Future signInWithFacebook() async {
    try {
      var loginResult = await FacebookSignInApi.login();
      print('logged in');
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

  Widget createContinueWithButton(String lable) {
    return OutlinedButton(
      onPressed: lable == 'google' ? signInWithGoogle : signInWithFacebook,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lable == 'google'
                ? Logo(Logos.google, size: 20)
                : Logo(
                    Logos.facebook_f,
                    size: 20,
                    color: Colors.white,
                  ),
            Text("Continue with $lable", style: const TextStyle(fontSize: 19)),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext ctx) {
    var appBar = AppBar(
      leading: const CloseButton(),
      centerTitle: true,
      title: Logo(Logos.reddit),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            Navigator.of(ctx).pushReplacementNamed(signupScreen);
          },
          child: const Text(
            "Sign up",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
    //initialize the textfields to be empty when the bottom sheet is opened
    emailController.text = "";
    usernameController.text = "";
    passwordController.text = "";
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height -
                MediaQuery.of(ctx).padding.top -
                appBar.preferredSize
                    .height), //the page height - appbar height - status bar height
        context: ctx,
        builder: (_) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              appBar: appBar,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                createTextSpan(
                                    "By continuing, you agree to our ", false),
                                createTextSpan("User Agreement ", true),
                                createTextSpan(
                                    "and acknowledge that you understand the ",
                                    false),
                                createTextSpan("Privacy Policy ", true),
                                createTextSpan(".", false),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            createContinueWithButton('google'),
                            const SizedBox(height: 10),
                            createContinueWithButton('facebook'),
                            const SizedBox(height: 15),
                            Row(children: const <Widget>[
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                indent: 30,
                                endIndent: 30,
                              )),
                              Text("OR", style: TextStyle(color: Colors.grey)),
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                indent: 30,
                                endIndent: 30,
                              )),
                            ]),
                            const SizedBox(height: 10),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: const EdgeInsets.all(15),
                                hintText: 'Email',
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
                              onChanged: (value) {
                                setState(() {
                                  int index = value.indexOf('@');
                                  if (index != -1) {
                                    emailCorrect =
                                        value.contains('.', index + 2) &&
                                            value[value.length - 1] != '.' &&
                                            value[value.length - 1] != ' ';
                                  }
                                });
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: usernameController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                contentPadding: const EdgeInsets.all(15),
                                hintText: 'Username',
                                errorText: (redundantUsername
                                    ? "Username already exists. Please try again with a different username."
                                    : null),
                              ),
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp(r'[a-zA-Z0-9_-]')),
                              //   FilteringTextInputFormatter.
                              // ],
                              // onChanged: (value) => setState(() {
                              //   usernameError =
                              //       value.contains(RegExp(r'[^a-zA-Z0-9_-]'));
                              // }),
                              // onSubmitted: (value) => checkOnUsername(value),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: passwordController,
                              style: const TextStyle(fontSize: 18),
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: const EdgeInsets.all(15),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() {
                                    passwordVisible = !passwordVisible;
                                  }),
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                prefixIcon: passwordController.text.isEmpty
                                    ? null
                                    : passwordCorrect
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
                                errorText: passwordCorrect ||
                                        passwordController.text.isEmpty
                                    ? null
                                    : "Password cannot contain your username",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  passwordCorrect =
                                      !value.contains(usernameController.text);
                                });
                              },
                              textInputAction: TextInputAction.done,
                            ),
                            // SizedBox(
                            //     height: MediaQuery.of(ctx).size.height * 0.005),
                            // Text(
                            //   usernameError
                            //       ? "This user name is already taken"
                            //       : "",
                            //   style: const TextStyle(
                            //     color: Colors.red,
                            //   ),
                            // ),
                            // SizedBox(
                            //     height: MediaQuery.of(ctx).size.height * 0.005),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.all(15),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ElevatedButton(
                        onPressed: () => loginContinue(context),
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          padding:
                              MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                        ),
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 139, 9, 0),
                                Color.fromARGB(255, 255, 136, 0)
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 88.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: const Text(
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
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => openBottomSheet(context),
            child: const Text("Login")),
      ),
    );
  }
}
