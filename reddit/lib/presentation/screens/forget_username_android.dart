import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/strings.dart';
import '../../helper/dio.dart';

class ForgetUsernameAndroid extends StatefulWidget {
  const ForgetUsernameAndroid({super.key});

  @override
  State<ForgetUsernameAndroid> createState() => _ForgetUsernameAndroidState();
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

class _ForgetUsernameAndroidState extends State<ForgetUsernameAndroid> {
  var emailController = TextEditingController();
  bool emailCorrect = false;
  bool emailEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.text = "";
  }

  void emailMe() async {
    await DioHelper.postData(url: "/api/auth/forget-username", data: {
      "email": emailController.text,
    }).then((value) {
      if (value.statusCode == 201) {
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
        Navigator.of(context).pushReplacementNamed(loginScreen);
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
    //initialize the textfields to be empty when the bottom sheet is opened
    var appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: Text(
                      "Recover username",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: emailEmpty
                          ? null
                          : emailCorrect
                              ? const Icon(
                                  IconData(0xf635, fontFamily: 'MaterialIcons'),
                                  color: Colors.green,
                                )
                              : const Icon(
                                  IconData(0xf713, fontFamily: 'MaterialIcons'),
                                  color: Colors.red,
                                ),
                      suffixIcon: emailEmpty
                          ? null
                          : IconButton(
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
                            ),
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
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      createTextSpan(
                          "Unfortunately, if you have never given us your email,\n",
                          false),
                      createTextSpan(
                          "you won't be able to reset your password.", false),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 20, 0, MediaQuery.of(context).size.height * 0.4),
                  child: TextButton(
                    onPressed: () => launchUrl(
                      Uri.parse(
                          "https://reddit.zendesk.com/hc/en-us/articles/205240005-How-do-I-log-in-to-Reddit-if-I-forgot-my-password-"),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: const Text(
                      "Having trouble?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ElevatedButton(
                onPressed: emailCorrect ? emailMe : null,
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
                    gradient: emailCorrect
                        ? const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 139, 9, 0),
                              Color.fromARGB(255, 255, 136, 0)
                            ],
                          )
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Email me',
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
  }
}
