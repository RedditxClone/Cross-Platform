// ignore_for_file: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/strings.dart';
import '../../business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import '../../data/model/auth_model.dart';

class SignupWeb2 extends StatefulWidget {
  const SignupWeb2({super.key, required this.userEmail});
  final String userEmail;
  @override
  State<SignupWeb2> createState() => _SignupWeb2State(userEmail);
}

class _SignupWeb2State extends State<SignupWeb2> {
  late String userEmail;
  _SignupWeb2State(this.userEmail);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordCorrect = false;
  bool passwordVisible = true;
  bool usernameLengthError = false;
  bool passwordLengthError = false;
  bool usernameEmpty = true;
  bool passwordEmpty = true;
  bool isAvailable = true;
  bool usernameError = false;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  List<String> suggestedUsernames = [];

  @override
  void initState() {
    super.initState();
    usernameController.text = "";
    passwordController.text = "";
    usernameFocusNode.addListener(_onFocusChangeUsername);
    passwordFocusNode.addListener(_onFocusChangePassword);
    getSuggestedUsernames();
    usernameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.removeListener(_onFocusChangeUsername);
    usernameFocusNode.dispose();
    passwordFocusNode.removeListener(_onFocusChangePassword);
    passwordFocusNode.dispose();
  }

  ///This function to get reccomended usernames from the server  ///
  /// This function calls the function [_SignupWeb2State.getSuggestedUsernames] to get all user's safety settings,
  /// then calls [AuthCubit.getSuggestedUsernames] to get user's blocked list.
  void getSuggestedUsernames() async {
    BlocProvider.of<AuthCubit>(context).getSuggestedUsernames();
  }

  //call back function for username focus node to be called of the focus changes
  void _onFocusChangeUsername() {
    debugPrint("Focus on username: ${usernameFocusNode.hasFocus.toString()}");
    if (!usernameFocusNode.hasFocus) {
      usernameEmpty = usernameController.text.isEmpty;
      usernameError =
          usernameController.text.contains(RegExp(r'[^a-zA-Z0-9_-]'));
      usernameLengthError = usernameController.text.length < 3 ||
          usernameController.text.length > 20;
      checkOnUsername(usernameController.text);
    }
  }

  //call back function for password focus node to be called of the focus changes
  void _onFocusChangePassword() {
    debugPrint("Focus on password: ${passwordFocusNode.hasFocus.toString()}");
  }

  //function takes the username and checks if it is valid or not
  //this fucntion is called if the user pressed next after typing the username or if the focus is lost from the username field
  void checkOnUsername(String usrName) async {
    BlocProvider.of<AuthCubit>(context).checkOnUsername(usrName);
  }

  //function to sign up with reddit accound it's called when the user presses the sign up button or if the user pressed done after typing the password
  void signUpContinue(BuildContext ctx) async {
    BlocProvider.of<AuthCubit>(ctx)
        .signup(passwordController.text, usernameController.text, userEmail);
  }

  Widget mainBody() {
    return Theme(
      data: ThemeData.light(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          TextField(
                            focusNode: usernameFocusNode,
                            controller: usernameController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Username',
                              labelText: 'Username',
                              errorText: usernameEmpty
                                  ? null
                                  : usernameError
                                      ? "Username can only contain letters, numbers, '-' and '_'"
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
                                              !usernameEmpty &&
                                              isAvailable
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
                            onEditingComplete: () {
                              usernameEmpty = usernameController.text.isEmpty;
                              usernameError = usernameController.text
                                  .contains(RegExp(r'[^a-zA-Z0-9_-]'));
                              usernameLengthError =
                                  usernameController.text.length < 3 ||
                                      usernameController.text.length > 20;
                              checkOnUsername(usernameController.text);
                              passwordFocusNode.requestFocus();
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          TextField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            style: const TextStyle(fontSize: 18),
                            obscureText: passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  passwordVisible = !passwordVisible;
                                }),
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              prefixIcon: passwordEmpty
                                  ? null
                                  : passwordCorrect && !passwordLengthError
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
                              hintText: 'Password',
                              labelText: 'Password',
                              errorText: passwordEmpty
                                  ? null
                                  : !passwordCorrect
                                      ? "Password cannot contain your username"
                                      : passwordLengthError
                                          ? "Password must be at least 8 characters"
                                          : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                passwordLengthError = value.length < 8;
                                passwordEmpty = value.isEmpty;
                                passwordCorrect =
                                    !value.contains(usernameController.text);
                              });
                            },
                            textInputAction: TextInputAction.done,
                            onEditingComplete: !usernameFocusNode.hasFocus &&
                                    !usernameLengthError &&
                                    !usernameError &&
                                    !usernameEmpty &&
                                    isAvailable
                                ? () => signUpContinue(context)
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Here are some username suggestions",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            IconButton(
                              onPressed: () {
                                getSuggestedUsernames();
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        ...suggestedUsernames.map((e) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                usernameController.text = e;
                                usernameEmpty = false;
                                isAvailable = true;
                                usernameError = false;
                                usernameLengthError =
                                    usernameController.text.length < 3 ||
                                        usernameController.text.length > 20;
                                passwordFocusNode.requestFocus();
                              });
                            },
                            child: Text(
                              e,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: MediaQuery.of(context).size.height < 600 ? 2 : 1,
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
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: ElevatedButton(
                            onPressed: !usernameLengthError &&
                                    !passwordLengthError &&
                                    passwordCorrect &&
                                    !passwordEmpty &&
                                    !usernameError &&
                                    !usernameEmpty &&
                                    isAvailable
                                ? () => signUpContinue(context)
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 42, 94, 137),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is SuggestedUsername) {
            suggestedUsernames = state.usernames;
            debugPrint("from signup$suggestedUsernames");
            return mainBody();
          }
          if (state is UserNameAvialable) {
            isAvailable = state.isAvailable;
            debugPrint("from signup $isAvailable");
            return mainBody();
          }

          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
        listener: (context, state) {
          if (state is SignedIn) {
            if (state.userDataJson != {}) {
              UserData.initUser(state.userDataJson); //this couldn't be null
              Navigator.of(context).pushNamed(
                homePageRoute,
              );
            } else {
              //user = null
              debugPrint("failed in signing up");
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
                        'Username or password is incorrect',
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
