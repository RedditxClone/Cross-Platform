import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/signin.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/web_services/authorization/login_conroller.dart';
import '../../helper/dio.dart';

class SignupMobile extends StatefulWidget {
  const SignupMobile({super.key});

  @override
  State<SignupMobile> createState() => _SignupMobileState();
}

class _SignupMobileState extends State<SignupMobile> {
  bool passwordVisible = true;
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool usernameError = false;
  bool usernameLengthError = false;
  bool passwordLengthError = false;
  bool emailCorrect = false;
  bool passwordCorrect = false;
  bool emailEmpty = true;
  bool usernameEmpty = true;
  bool passwordEmpty = true;
  bool redundantUsername = false;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  late User? newUser;

  @override
  void initState() {
    super.initState();
    emailController.text = "";
    usernameController.text = "";
    passwordController.text = "";
    usernameFocusNode.addListener(_onFocusChangeUsername);
    emailFocusNode.addListener(_onFocusChangeEmail);
    passwordFocusNode.addListener(_onFocusChangePassword);
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    emailFocusNode.removeListener(_onFocusChangeEmail);
    emailFocusNode.dispose();
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

  //call back function for email focus node to be called of the focus changes
  void _onFocusChangeEmail() {
    debugPrint("Focus on email: ${emailFocusNode.hasFocus.toString()}");
  }

  //call back function for password focus node to be called of the focus changes
  void _onFocusChangePassword() {
    debugPrint("Focus on password: ${passwordFocusNode.hasFocus.toString()}");
  }

//toggle the password visibility
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
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
      "email": emailController.text,
    }).then((value) {
      if (value.statusCode == 201) {
        newUser = User.fromJson(jsonDecode(value.data));
        Navigator.of(ctx).pushReplacementNamed(
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
              Navigator.of(context).pushReplacementNamed(loginScreen);
            },
            child: const Text(
              "Log in",
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
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
                child: Text(
                  "Hi new friend, welcome to Reddit",
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
                  focusNode: emailFocusNode,
                  controller: emailController,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    hintText: 'Email',
                    labelText: 'Email',
                    suffixIcon: emailEmpty && !emailFocusNode.hasFocus
                        ? null
                        : !emailEmpty && emailFocusNode.hasFocus
                            ? IconButton(
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
                              )
                            : !emailFocusNode.hasFocus &&
                                    emailCorrect &&
                                    !emailEmpty
                                ? const Icon(
                                    IconData(0xf635,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.green,
                                  )
                                : null,
                    errorText: !emailCorrect && !emailEmpty
                        ? "Not a valid email address"
                        : null,
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
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  focusNode: usernameFocusNode,
                  controller: usernameController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
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
                                : redundantUsername
                                    ? "Username already exists"
                                    : null,
                    suffixIcon: usernameEmpty && !usernameFocusNode.hasFocus
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
                      usernameError = value.contains(RegExp(r'[^a-zA-Z0-9_-]'));
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
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
                                IconData(0xf635, fontFamily: 'MaterialIcons'),
                                color: Colors.green,
                              )
                            : const Icon(
                                IconData(0xf713, fontFamily: 'MaterialIcons'),
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
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  onPressed: !passwordEmpty &&
                          !passwordLengthError &&
                          !usernameEmpty &&
                          !usernameError &&
                          !usernameLengthError &&
                          emailCorrect &&
                          !emailEmpty &&
                          !redundantUsername
                      ? () => signUpContinue(context)
                      : null,
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.all(15),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          signUpContinue();
                        }),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(80.0)),
                        // padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: !passwordEmpty &&
                              !passwordLengthError &&
                              !usernameEmpty &&
                              !usernameError &&
                              !usernameLengthError &&
                              emailCorrect &&
                              !emailEmpty &&
                              !redundantUsername
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
