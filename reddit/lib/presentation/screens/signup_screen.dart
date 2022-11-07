import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUp {
  bool passwordVisible = true;
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  void signUpContinue() {
    print("Email : ${emailController.text}");
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              lable == 'google'
                  ? Logo(Logos.google, size: 20)
                  : Logo(Logos.facebook_f, size: 20),
              Text("Continue with $lable",
                  style: const TextStyle(fontSize: 19)),
              const SizedBox(width: 20),
            ],
          ),
        ));
  }

  void openBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height -
                MediaQuery.of(ctx).padding.top),
        context: ctx,
        builder: (_) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              appBar: AppBar(
                leading: const CloseButton(),
                centerTitle: true,
                title: Logo(Logos.reddit),
                actions: [
                  TextButton(
                      onPressed: () {},
                      child:
                          const Text("Log in", style: TextStyle(fontSize: 20)))
                ],
              ),
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
                                      borderRadius: BorderRadius.circular(25)),
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: 'Email',
                                )),
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
                                          : Icons.visibility_off)),
                                  hintText: 'Password',
                                )),
                            const SizedBox(height: 10),
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
                        onPressed: () => setState(() {
                          signUpContinue();
                        }),
                        //*shape: RoundedRectangleBorder(
                        //*   borderRadius: BorderRadius.circular(80.0)),
                        //*padding: const EdgeInsets.all(0.0),
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
}
