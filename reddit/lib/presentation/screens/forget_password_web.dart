import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import 'package:url_launcher/link.dart';

import '../../helper/dio.dart';

class ForgetPasswordWeb extends StatefulWidget {
  const ForgetPasswordWeb({super.key});

  @override
  State<ForgetPasswordWeb> createState() => _ForgetPasswordWebState();
}

class _ForgetPasswordWebState extends State<ForgetPasswordWeb> {
  var emailController = TextEditingController();
  bool emailCorrect = false;
  bool emailEmpty = true;
  bool usernameEmpty = true;
  bool usernameError = false;
  bool usernameLengthError = false;
  var usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  final textStyleForLinks = const TextStyle(
    fontSize: 12,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  @override
  void initState() {
    super.initState();
    emailController.text = "";
    usernameController.text = "";
    usernameFocusNode.addListener(_onFocusChangeUsername);
    emailFocusNode.addListener(_onFocusChangeEmail);
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    emailFocusNode.removeListener(_onFocusChangeEmail);
    emailFocusNode.dispose();
  }

  //call back function for username focus node to be called of the focus changes
  void _onFocusChangeUsername() {
    debugPrint("Focus on username: ${usernameFocusNode.hasFocus.toString()}");
  }

  //call back function for email focus node to be called of the focus changes
  void _onFocusChangeEmail() {
    debugPrint("Focus on email: ${emailFocusNode.hasFocus.toString()}");
  }

  void emailMe() async {
    await DioHelper.postData(url: "/api/auth/forget_password", data: {
      "email": emailController.text,
      "username": usernameController.text,
    }).then((value) {
      if (value.statusCode == 201) {
        debugPrint("Email sent");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Logo(
                  Logos.reddit,
                  color: Colors.green,
                  size: 25,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                const Text("Email sent successfully"),
              ],
            ),
          ),
        );
        Navigator.of(context).pushNamed(loginPage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your email is not registered"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Theme(
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
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 5,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Logo(
                            Logos.reddit,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                          "Reset your password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "Tell us the username and email address associated with",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "your Reddit account, and we’ll send you an email with a link",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "to reset your password.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            focusNode: usernameFocusNode,
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Username',
                              labelText: 'Username',
                              errorText: usernameEmpty
                                  ? null
                                  : usernameError
                                      ? "Username can only contain letters, numbers,'-' and '_'"
                                      : usernameLengthError
                                          ? "Username must be between 3 and 20 characters"
                                          : null,
                              suffixIcon: usernameEmpty &&
                                      !usernameFocusNode.hasFocus
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
                                              !usernameEmpty
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
                                usernameError =
                                    value.contains(RegExp(r'[^a-zA-Z0-9_-]'));
                                usernameLengthError =
                                    value.length < 3 || value.length > 20;
                              });
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextField(
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
                                  emailCorrect =
                                      value.contains('.', index + 2) &&
                                          value[value.length - 1] != '.' &&
                                          value[value.length - 1] != ' ';
                                }
                              });
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            width: 400,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: emailCorrect &&
                                      !usernameLengthError &&
                                      !usernameError
                                  ? emailMe
                                  : null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 25, 116, 191),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "RESET PASSWORD",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(forgetUsernameWeb),
                            child: const Text(
                              "FORGOT USERNAME?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 42, 94, 137),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Wrap(
                            children: [
                              const Text(
                                "Don't have an email or need assistance logging in? ",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 85, 83, 83),
                                  fontSize: 12,
                                ),
                              ),
                              Link(
                                uri: Uri.parse(getHelpPage),
                                target: LinkTarget.blank,
                                builder: (context, followLink) => InkWell(
                                  onTap: followLink,
                                  child: Text(
                                    "GET HELP",
                                    style: textStyleForLinks,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Wrap(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(loginPage);
                                },
                                child: const Text(
                                  "LOG IN",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 42, 94, 137),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(SIGNU_PAGE1);
                                },
                                child: const Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 42, 94, 137),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
