import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/data/model/signin.dart';
import 'package:url_launcher/url_launcher.dart';
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
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool usernameEmpty = true;
  bool passwordEmpty = true;

  late User newUser;
  @override
  void initState() {
    super.initState();
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  void loginContinue(BuildContext ctx) async {
    await DioHelper.postData(url: '/api/auth/login', data: {
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

//TODO: add API request to save the data of google and facebook users
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
        side: const BorderSide(color: Colors.white, width: 1),
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
            Text("Continue with $lable",
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                )),
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
    usernameController.text = "";
    passwordController.text = "";
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(ctx).size.height -
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              "Log in to Reddit",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            createContinueWithButton('google'),
                            const SizedBox(height: 10),
                            createContinueWithButton('facebook'),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            TextField(
                              controller: usernameController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.all(15),
                                hintText: 'Username',
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
                              onChanged: (value) => setState(() {
                                usernameEmpty = value.isEmpty;
                              }),
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
                                  borderRadius: BorderRadius.circular(10),
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
                                hintText: 'Password',
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) => setState(() {
                                passwordEmpty = value.isEmpty;
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005),
                    TextButton(
                      onPressed: (() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(forgetPasswordAndroid);
                      }),
                      child: const Text(
                        "Forget password",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        createTextSpan(
                            "By continuing, you agree to our ", false),
                        createTextSpan("User Agreement ", true,
                            url:
                                "https://www.redditinc.com/policies/user-agreement"),
                        createTextSpan("and ", false),
                        createTextSpan("Privacy Policy ", true,
                            url:
                                "https://www.reddit.com/policies/privacy-policy"),
                        createTextSpan(".", false),
                      ]),
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.all(15),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ElevatedButton(
                        onPressed: !usernameEmpty && !passwordEmpty
                            ? () => loginContinue(context)
                            : null,
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
                          decoration: BoxDecoration(
                            gradient: !usernameEmpty && !passwordEmpty
                                ? const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 139, 9, 0),
                                      Color.fromARGB(255, 255, 136, 0)
                                    ],
                                  )
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(80.0)),
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
