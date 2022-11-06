import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';

class ForgetPasswordWeb extends StatefulWidget {
  const ForgetPasswordWeb({super.key});

  @override
  State<ForgetPasswordWeb> createState() => _ForgetPasswordWebState();
}

class _ForgetPasswordWebState extends State<ForgetPasswordWeb> {
  var emailController = TextEditingController();
  bool emailCorrect = false;
  bool emailEmpty = false;
  var usernameController = TextEditingController();
  //Todo: reset password function
  void resetPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
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
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //insert logo here
                      Logo(Logos.reddit, size: 40),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Reset your password\n\n",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Tell us the username and email address associated with\n",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "your Reddit account, and we’ll send you an email with a link\n",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "to reset your password.\n\n",
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: "CHOOSE A USERNAME",
                            label: Text("CHOOSE A USERNAME"),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          maxLines: 1,
                          textInputAction: TextInputAction.unspecified,
                          onEditingComplete: () {
                            setState(() {
                              //TODO: check if username is used
                              //api call to check if username is used

                              // if (//check on the returned value from the api
                              //     ) {
                              //   usernameUsed = true;
                              // } else {
                              //   usernameUsed = false;
                              // }
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
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
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: resetPassword,
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
                            "RESET PASSWORD",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
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
      ),
    );
  }
}
