// ignore_for_file: use_build_context_synchronously
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/strings.dart';
import '../../data/model/auth_model.dart';
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
  final userAgreementUrl = Uri.parse(USER_AGGREMENT);
  final privacyPolicyUrl = Uri.parse(PRIVACY_POLICY);
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
  void signInWithGoogle() async {
    try {
      var googleAccount = await GoogleSingInApi.loginWeb();
      if (googleAccount != null) {
        var googleToken = await GoogleSingInApi.getGoogleToken();
        if (googleToken != null) {
          debugPrint("token is $googleToken");
          BlocProvider.of<AuthCubit>(context).loginWithGoogle(googleToken);
        } else {
          debugPrint("token is null");
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
      } else {
        debugPrint("google account is null");
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
      debugPrint("error in google sign in $e");
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

//this an async fucntion to log in with github account and store the result in database
  Future signInWithGithub() async {
    try {
      // var loginResult = await FacebookSignInApi.login();
      // if (loginResult != null) {
      //   var fbUser = await FacebookSignInApi
      //       .getUserData(); //post request to add user data
      //   DioHelper.postData(url: '/api/auth/signup', data: {
      //     "name": fbUser['name'] as String,
      //     "email": fbUser['email'] as String,
      //     "imageUrl": fbUser['picture']['data']['url'] as String,
      //     "userId": loginResult.accessToken?.userId,
      //     "_type": "facebook",
      //     "accessToken": loginResult.accessToken?.token,
      //   }).then((value) {
      //     if (value.statusCode == 201) {
      //       newUser = User.fromJson(jsonDecode(value.data));
      //       Navigator.of(context).pushReplacementNamed(
      //         chooseGenderScreen,
      //         arguments: newUser,
      //       );
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Row(
      //             children: [
      //               const Icon(
      //                 Icons.error,
      //                 color: Colors.red,
      //               ),
      //               SizedBox(
      //                 width: MediaQuery.of(context).size.width * 0.01,
      //               ),
      //               const Text(
      //                 "Error in Signing in with Facebook",
      //                 style: TextStyle(
      //                   color: Colors.red,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   });
      // }
      launchUrl(
        Uri.parse(
            'https://github.com/login/oauth/authorize?client_id=$gitHubClientID'),
        webOnlyWindowName: '_self',
      );
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
                "Error in Signing in with github",
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

//This function creates buttonns for login with google and github
//it takes a string that determines the function of the button depends on the passed value
//is it for google or github
  Widget createContinueWithButton(String lable) {
    return OutlinedButton.icon(
      onPressed: lable == 'google' ? signInWithGoogle : signInWithGithub,
      icon: Logo(
        lable == 'google' ? Logos.google : Logos.github,
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
              : const EdgeInsets.fromLTRB(30, 20, 52, 20),
        ),
      ),
    );
  }

  void continieSignUp() {
    Navigator.of(context).pushNamed(
      SIGNU_PAGE2,
      arguments:
          emailController.text, //send the email takes from the text field
    );
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
                          "Sign up",
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
                              "By continuing, you are setting up a Reddit ",
                              style: textStyleForPolicy,
                            ),
                            Text(
                              "account and agree to our ",
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
                    createContinueWithButton("Github"),
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
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 270,
                        child: TextField(
                          autofocus: true,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            labelText: 'Email',
                            helperText: 'Email',
                            errorText:
                                emailCorrect || emailController.text.isEmpty
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
                          onEditingComplete:
                              emailCorrect ? continieSignUp : null,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 270,
                        height: 45,
                        child: ElevatedButton(
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
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
            if (state.userDataJson != {}) {
              UserData.initUser(state.userDataJson); //this couldn't be null
              debugPrint("success in login");
              Navigator.of(context).pushReplacementNamed(
                homePageRoute,
              );
            } else {
              //user = null
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
                        'Please Try Again',
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
