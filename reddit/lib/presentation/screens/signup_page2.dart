import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
import '../../data/model/signin.dart';

class SignupWeb2 extends StatefulWidget {
  const SignupWeb2({super.key, required this.user});
  final User user;
  @override
  State<SignupWeb2> createState() => _SignupWeb2State(user: user);
}

class _SignupWeb2State extends State<SignupWeb2> {
  final User user;
  _SignupWeb2State({required this.user});
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordCorrect = false;
  bool usernameUsed = false;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
        child: AppBar(
          title: Container(
            padding: const EdgeInsets.fromLTRB(30, 40, 0, 30),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Choose your username\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Your username is how other community members will see you. This name will be used to credit you for things you share on Reddit. What should we call you?",
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
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
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "PASSWORD",
                      label: const Text("PASSWORD"),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          passwordVisible = !passwordVisible;
                        }),
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      prefixIcon: passwordController.text.isEmpty
                          ? null
                          : passwordCorrect
                              ? const Icon(
                                  IconData(0xf635, fontFamily: 'MaterialIcons'),
                                  color: Colors.green,
                                )
                              : const Icon(
                                  IconData(0xf713, fontFamily: 'MaterialIcons'),
                                  color: Colors.red,
                                ),
                      errorText: passwordController.text.isEmpty
                          ? null
                          : passwordCorrect
                              ? null
                              : "Password cannot contain your username",
                    ),
                    maxLines: 1,
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => setState(() {
                      passwordCorrect =
                          !value.contains(usernameController.text);
                    }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          SIGNU_PAGE1,
                        ); //navigate to SIGN UP 1 page
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (passwordCorrect && !usernameUsed) {
                          user.name = usernameController.text;
                          user.password = passwordController.text;
                          Navigator.of(context).pushReplacementNamed(
                            HOME_PAGE,
                            arguments: user,
                          ); //to the home page
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(50, 18, 50, 18),
                        ),
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
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
      ),
    );
  }
}
