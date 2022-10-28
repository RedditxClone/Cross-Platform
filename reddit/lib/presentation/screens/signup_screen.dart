import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../helper/dio.dart';
import 'home.dart';

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
  GoogleSignIn? _currentUser;
  @override
  void initState() {
    super.initState();
    // _currentUser = GoogleSignIn(
    //   scopes: [
    //     'profile',
    //     'email',
    //   ],
    // );
    emailController.text = "";
    usernameController.text = "";
    passwordController.text = "";
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  void signUpContinue() {
    Response res = DioHelper.postData(url: '/api/auth/signup', data: {
      "email": emailController.text,
      "password": passwordController.text,
      "name": usernameController.text,
      "birthdate": "2022-10-27T18:44:44.105Z",
      "image": "null"
    }) as Response;
    if (res.statusCode == 201) {
      Navigator.pushNamed(context, 'Home', arguments: res.data);
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

  Widget createContinueWithButton(String lable) {
    return OutlinedButton(
      onPressed: () {
        //GoogleSignIn().signIn();
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
    bool emailCorrect = false;
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
                                )),
                            const SizedBox(height: 10),
                            TextField(
                              controller: passwordController,
                              style: const TextStyle(fontSize: 18),
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
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
                            ),
                            SizedBox(
                                height: MediaQuery.of(ctx).size.height * 0.005),
                            Text(
                              usernameError
                                  ? "This user name is already taken"
                                  : "",
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(ctx).size.height * 0.005),
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
                        onPressed: signUpContinue,
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
