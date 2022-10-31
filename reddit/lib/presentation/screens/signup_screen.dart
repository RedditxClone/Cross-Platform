import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/presentation/screens/home.dart';
import '../../data/web_services/authorization/login_conroller.dart';
import '../../helper/dio.dart';

class SignupMobile extends StatefulWidget {
  const SignupMobile({super.key});

  @override
  State<SignupMobile> createState() => _SignupMobileState();
}

class _SignupMobileState extends State<SignupMobile> {
  bool passwordVisible = true;
  var emailController = TextEditingController(text: '');
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool usernameError = false;
  bool emailCorrect = false;
  bool passwordCorrect = false;
  bool redundantUsername = false;
  @override
  void initState() {
    super.initState();
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  // void _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //     if (user != null) {
  //       final User currentUser = await _currentUser!.signInSilently();
  //       assert(user.uid == currentUser.uid);
  //       print('signInWithGoogle succeeded: $user');
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => Home(),
  //         ),
  //       );
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
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

  void signUpContinue(BuildContext ctx) async {
    if (emailCorrect && !usernameError) {}
    var res = await DioHelper.postData(url: '/api/auth/signup', data: {
      "email": emailController.text,
      "password": passwordController.text,
      "name": usernameController.text,
      "birthdate": "2022-10-27T18:44:44.105Z",
      "image": "null"
    }) as Response;
    if (res.statusCode == 201) {
      print(res.data);
      Navigator.of(ctx).pushNamed(
        "Home",
        arguments: res.data,
      );
    } else {
      setState(() {
        usernameError = true;
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
    var googleAccount = await GoogleSingInApi.login();
    if (googleAccount != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(googleSignInAccount: googleAccount),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error in Signing in with Google"),
        ),
      );
    }
  }

  Widget createContinueWithButton(String lable) {
    return OutlinedButton(
      onPressed: () {
        signInWithGoogle();
      },
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
                : Logo(Logos.facebook_f, size: 20),
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
          onPressed: () {},
          child: const Text(
            "Log in",
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
                            const Text("Hi new friend, welcome to Reddit",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20),
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
                                            value[value.length - 1] != '.';
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
                              onChanged: (value) => setState(() {
                                usernameError =
                                    value.contains(RegExp(r'[^a-zA-Z0-9_-]'));
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
                                    : "Password must be at least 8 characters",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  passwordCorrect = value.length >= 8;
                                });
                              },
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () => signUpContinue(context),
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
                        onPressed: () => signUpContinue(context),
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
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => openBottomSheet(context),
            child: const Text("Sign Up")),
      ),
    );
  }
}
