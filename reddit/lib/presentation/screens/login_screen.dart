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

  late User? newUser;

  @override
  void initState() {
    super.initState();
    //initialize the textfields to be empty when the bottom sheet is opened
    usernameController.text = "";
    passwordController.text = "";
  }

//toggle the password visibility
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  //function to log in with reddit accound it's called when the user presses the sign up button or if the user pressed done after typing the password
  void loginContinue(BuildContext ctx) async {
    DioHelper.postData(url: '/api/auth/login', data: {
      "password": passwordController.text,
      "name": usernameController.text,
    }).then((value) {
      if (value.statusCode == 201) {
        debugPrint('success login');
        newUser = User.fromJson(jsonDecode(value.data));
        Navigator.of(ctx).pushReplacementNamed(
          homePageRoute,
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

//this finction return a TextSpan
//it takes the text itself
//isUrl : bool to select the required style
//url : the url to be opened if the user pressed the text and isUrl is true
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

  //this an async fucntion to log in with google account and store the result in database
  Future signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginMob();
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
  // Future signInWithFacebook() async {
  //   try {
  //     var loginResult = await FacebookSignInApi.login();
  //     print('logged in');
  //     if (loginResult != null) {
  //       var fbUser = await FacebookSignInApi.getUserData();
  //       newUser = User(
  //         name: fbUser['name'] as String,
  //         email: fbUser['email'] as String,
  //         imageUrl: fbUser['picture']['data']['url'] as String,
  //         userId: fbUser['id'] as String,
  //       );
  //       Navigator.of(context).pushNamed(
  //         HOME_PAGE,
  //         arguments: newUser,
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Error in Signing in with Facebook"),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //     debugPrint(e.toString());
  //   }
  // }
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
          "token": loginResult.accessToken?.token,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              homePageRoute,
              arguments: newUser,
            );
          },
        ),
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
              Navigator.of(context).pushReplacementNamed(signupScreen);
            },
            child: const Text(
              "Sign up",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
                    child: Text(
                      "Log in to Reddit",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: createContinueWithButton('google'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: createContinueWithButton('facebook'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Row(children: const <Widget>[
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
                      controller: usernameController,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                      onChanged: (value) => setState(() {
                        usernameEmpty = value.isEmpty;
                      }),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: TextField(
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
                        hintText: 'Password',
                        labelText: 'Password',
                      ),
                      onChanged: (value) => setState(
                        () {
                          passwordEmpty = value.isEmpty;
                        },
                      ),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: !usernameEmpty && !passwordEmpty
                          ? () => loginContinue(context)
                          : null,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: TextButton(
                  onPressed: (() {
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
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  createTextSpan("By continuing, you agree to our ", false),
                  createTextSpan("User Agreement ", true,
                      url: "https://www.redditinc.com/policies/user-agreement"),
                  createTextSpan("and ", false),
                  createTextSpan("Privacy Policy ", true,
                      url: "https://www.reddit.com/policies/privacy-policy"),
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
                    padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
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
                      constraints:
                          const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
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
      ),
    );
  }
}
