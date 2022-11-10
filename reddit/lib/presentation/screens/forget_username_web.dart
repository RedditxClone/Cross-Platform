import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/helper/dio.dart';

class ForgetUsernameWeb extends StatefulWidget {
  const ForgetUsernameWeb({super.key});

  @override
  State<ForgetUsernameWeb> createState() => _ForgetUsernameWebState();
}

class _ForgetUsernameWebState extends State<ForgetUsernameWeb> {
  var emailController = TextEditingController();
  bool emailCorrect = false;
  bool emailEmpty = false;
  void emailMe() async {
    if (emailController.text.isEmpty) {
      setState(() {
        emailEmpty = true;
      });
    } else if (emailCorrect) {
      await DioHelper.postData(
        url: '/api/auth/forget-username',
        data: {"email": emailController.text},
      ).then((value) {
        if (value.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "An email will be sent if the user exists in the database"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error!! please try again later"),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Logo(Logos.reddit, size: 40),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Recover your username\n\n",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Tell us the email address associated with your Reddit\n",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                "account, and we’ll send you an email with your username.\n\n",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              : emailCorrect && emailEmpty == false
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
                          errorText: emailEmpty
                              ? 'Please enter an email address to continue'
                              : null,
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
                            emailEmpty = emailController.text.isEmpty;
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: emailMe,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 25, 116, 191),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20),
                          ),
                        ),
                        child: const Text(
                          "EMAIL ME",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Don't have an email or need assistance logging in?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 83, 83),
                              fontSize: 12,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(getHelpPage), //go to get help page
                            child: const Text(
                              " GET HELP",
                              style: TextStyle(
                                color: Color.fromARGB(255, 42, 94, 137),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(loginPage);
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
                              Navigator.of(context)
                                  .pushReplacementNamed(SIGNU_PAGE1);
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
    );
  }
}
