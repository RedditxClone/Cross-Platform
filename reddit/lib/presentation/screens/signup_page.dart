import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignupWeb extends StatefulWidget {
  const SignupWeb({super.key});

  @override
  State<SignupWeb> createState() => _SignupWebState();
}

class _SignupWebState extends State<SignupWeb> {
  TextSpan createTextSpan(String txt, bool isUrl) {
    return TextSpan(
      text: txt,
      style: TextStyle(
        fontSize: 14,
        color: isUrl ? Colors.blue : Colors.black,
        decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  Widget createContinueWithButton(String lable) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Logo(
        lable == 'google' ? Logos.google : Logos.facebook_logo,
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
              : const EdgeInsets.fromLTRB(30, 20, 30, 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textStyleForPolicy = TextStyle(
      fontSize: 12,
      color: Colors.black,
    );
    const textStyleForLinks = TextStyle(
      fontSize: 12,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Row(
          children: [
            // SizedBox(
            //   height: double.infinity,
            //   child: Image.asset(
            //     'assets/images/sidelogo.png',
            //     width: MediaQuery.of(context).size.width * 0.09,
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
            // Container(
            //   // width: MediaQuery.of(context).size.width * 0.91,
            //   height: double.infinity,
            //   margin: const EdgeInsets.all(0),
            //   padding: EdgeInsets.only(
            //       left: MediaQuery.of(context).size.width * 0.02),
            //   child: Column(
            //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             "Sign Up",
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           ),
            //           SizedBox(
            //             height: MediaQuery.of(context).size.height * 0.01,
            //           ),
            //           const Text(
            //             "By continuing, you are setting up a Reddit",
            //             style: textStyleForPolicy,
            //           ),
            //           SizedBox(
            //             height: MediaQuery.of(context).size.height * 0.005,
            //           ),
            //           Row(
            //             children: [
            //               const Text(
            //                 "account and agree to our ",
            //                 style: textStyleForPolicy,
            //               ),
            //               InkWell(
            //                 onTap: () => print("click"),
            //                 child: const Text(
            //                   "User Agreement",
            //                   style: textStyleForLinks,
            //                 ),
            //               ),
            //               const Text(" and ", style: textStyleForPolicy),
            //               InkWell(
            //                 onTap: () => print("click"),
            //                 child: const Text(
            //                   "Privacy Policy",
            //                   style: textStyleForLinks,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           createContinueWithButton("google"),
            //           SizedBox(
            //             height: MediaQuery.of(context).size.height * 0.01,
            //           ),
            //           createContinueWithButton("facebook"),
            //         ],
            //       ),
                  // Row(
                  //   children: const <Widget>[
                  //     Divider(
                  //       height: 20,
                  //       thickness: 5,
                  //       indent: 20,
                  //       endIndent: 0,
                  //       color: Colors.black,
                  //     ),
                  //     Text(
                  //       "OR",
                  //       style: TextStyle(
                  //         color: Color.fromARGB(255, 85, 83, 83),
                  //         fontSize: 17,
                  //       ),
                  //     ),
                  //     Divider(
                  //       height: 20,
                  //       thickness: 5,
                  //       indent: 20,
                  //       endIndent: 0,
                  //       color: Colors.black,
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   width: 400,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(8),
                  //         ),
                  //       ),
                  //       labelText: 'Username',
                  //     ),
                  //     maxLines: 1,
                  //     maxLength: 50,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                ],
              // ),
            // )
          // ],
        ),
      ),
    );
  }
}