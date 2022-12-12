import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/helper/dio.dart';
import 'package:url_launcher/link.dart';

class ForgetUsernameWeb extends StatefulWidget {
  const ForgetUsernameWeb({super.key});

  @override
  State<ForgetUsernameWeb> createState() => _ForgetUsernameWebState();
}

class _ForgetUsernameWebState extends State<ForgetUsernameWeb> {
  var emailController = TextEditingController();
  bool emailCorrect = false;
  bool emailEmpty = true;
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
    emailFocusNode.addListener(_onFocusChangeEmail);
    emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.removeListener(_onFocusChangeEmail);
    emailFocusNode.dispose();
  }

  //call back function for email focus node to be called of the focus changes
  void _onFocusChangeEmail() {
    debugPrint("Focus on email: ${emailFocusNode.hasFocus.toString()}");
  }

  void emailMe() {
    BlocProvider.of<AuthCubit>(context).forgetUsername(emailController.text);
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
                        "Recover your username",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "Tell us the email address associated with your Reddit",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "account, and we’ll send you an email with your username.",
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
                          textInputAction: TextInputAction.done,
                          onEditingComplete: emailCorrect ? emailMe : null,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SizedBox(
                          width: 300,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: emailCorrect ? emailMe : null,
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
                              "EMAIL ME",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
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
          if (state is ForgetUsername) {
            if (state.isSent) {
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
              Navigator.of(context).pushNamed(loginScreen);
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
                        'Your email is not registered',
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
