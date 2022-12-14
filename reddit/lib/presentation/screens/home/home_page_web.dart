// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/web_services/authorization/auth_web_service.dart';
import 'package:reddit/helper/utils/shared_keys.dart';
import 'package:reddit/presentation/screens/home/home_web.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import '../../../../data/repository/auth_repo.dart';
import '../../../helper/utils/shared_pref.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  late AuthRepo authRepo;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context)
        .getUserData(PreferenceUtils.getString(SharedPrefKeys.userId));
    authRepo = AuthRepo(AuthWebService());
  }

  Map<String, String> interests = {
    "Funny": '🤣',
    "Jokes": '😂',
    "Interesting": '🤔',
    'Memes': '💩',
    'Lifehacks': '💡',
    'Nature': '🌿',
    'History': '📜',
    'Tech': '📱',
    'Science': '🔬',
    'News': '📰',
    'Career': '👔',
    'Books': '📚',
    'Programming': '👨‍💻',
    'Sports': '⚽',
    'space': '🚀',
    'Travel': '✈',
    'Fishing': '🎣',
  };
  Map<String, dynamic> selectedInterests = {};
  Uint8List? imgCover;
  int intersetsCount = 0;

  //this function is used to add the user interests to the database
  void addInterests() {
    authRepo
        .addInterests(selectedInterests, UserData.user!.token ?? "")
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
        showDialogToChooseProfilePicture();
      } else {
        SnackBar(
          content: Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Error in storing your data please try again',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      }
    });
    debugPrint("interests added");
  }

  //This function takes the selected gender and sends it to the server
  //gender will be null if not selected
  void selectGender(String gender) async {
    authRepo.genderInSignup(gender, UserData.user!.token!).then((updated) {
      if (updated) {
        debugPrint("success gender");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.reddit,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Data add successfully',
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
        Navigator.of(context).pop();
        showDialogToChooseInterests();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Error in storing your data please try again',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

//this fucntion to choose the gender of the user and send to the server
  void showDialogToChooseGender() {
    var buttonColor1 = const Color.fromARGB(255, 237, 237, 237);
    var buttonColor2 = const Color.fromARGB(255, 237, 237, 237);
    bool choosed = false;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => Theme(
            data: ThemeData.light(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              icon: const Icon(
                Icons.reddit,
                size: 40,
              ),
              iconColor: Colors.red,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    showDialogToChooseInterests();
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              title: const Text(
                "About you",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                height: MediaQuery.of(dialogContext).size.height * 0.5,
                width: MediaQuery.of(dialogContext).size.width * 0.3,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tell us about yourself to start building your home feed",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "I'm a...",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(dialogContext).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (!choosed) {
                              buttonColor1 ==
                                      const Color.fromARGB(255, 82, 46, 46)
                                  ? null
                                  : selectGender("male");
                              buttonColor1 =
                                  const Color.fromARGB(255, 82, 46, 46);
                              choosed = true;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: buttonColor1 ==
                                      const Color.fromARGB(255, 82, 46, 46)
                                  ? Colors.red
                                  : buttonColor1,
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(dialogContext).size.width,
                          child: const Text(
                            "Man",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (!choosed) {
                              buttonColor2 ==
                                      const Color.fromARGB(255, 82, 46, 46)
                                  ? null
                                  : selectGender("woman");
                              buttonColor2 =
                                  const Color.fromARGB(255, 82, 46, 46);
                              choosed = true;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: buttonColor2 ==
                                      const Color.fromARGB(255, 82, 46, 46)
                                  ? Colors.red
                                  : buttonColor2,
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: MediaQuery.of(dialogContext).size.width,
                          child: const Text(
                            "Woman",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//This function will show the dialog to choose interests
  void showDialogToChooseInterests() {
    selectedInterests.clear();
    intersetsCount = 0;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => Theme(
            data: ThemeData.light(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              icon: AppBar(
                elevation: 0,
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialogToChooseGender();
                  },
                ),
                backgroundColor: Colors.white,
                title: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Logo(
                    Logos.reddit,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                centerTitle: true,
              ),
              title: const Text(
                "Interests",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.25,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Pick things you'd like to see in your home feed",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 2,
                              runSpacing: 2,
                              children: [
                                ...interests.entries.map((e) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      side: selectedInterests.containsKey(e.key)
                                          ? const BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            )
                                          : BorderSide.none,
                                    ),
                                    color: selectedInterests.containsKey(e.key)
                                        ? const Color.fromARGB(255, 82, 46, 46)
                                        : Color(const Color.fromARGB(
                                                255, 237, 237, 237)
                                            .value),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      child: TextButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            if (!selectedInterests
                                                .containsKey(e.key)) {
                                              selectedInterests.addEntries([
                                                e
                                              ]); //add the selected interest to the map
                                              intersetsCount++;
                                            } else {
                                              intersetsCount--;
                                              selectedInterests.remove(e.key);
                                            }
                                            debugPrint(
                                                "count = $intersetsCount");
                                          });
                                          debugPrint(
                                              selectedInterests.toString());
                                        },
                                        icon: Text(
                                          e.value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        label: Text(
                                          e.key,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.all(15),
                          color: Colors.white,
                          child: ElevatedButton(
                            onPressed:
                                intersetsCount >= 3 ? addInterests : null,
                            style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: intersetsCount >= 3
                                    ? const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 139, 9, 0),
                                          Color.fromARGB(255, 255, 136, 0)
                                        ],
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color.fromARGB(50, 139, 9, 0),
                                          Color.fromARGB(50, 255, 136, 0)
                                        ],
                                      ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(80.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: intersetsCount < 3
                                    ? Text(
                                        '$intersetsCount of 3 Selected',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 20),
                                      )
                                    : const Text(
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// ## Parameters
  /// ### src : the image source can be ImageSource.gallery or ImageSource.camera
  /// ### dest : the image destination can be 'cover' for cover photo or 'profile' fom profile photo
  Future<bool> pickImageWeb(ImageSource src) async {
    try {
      final imagePicker = await ImagePicker().pickImage(source: src);
      if (imagePicker == null) return false;
      imgCover = await imagePicker.readAsBytes();
      // BlocProvider.of<AuthCubit>(context)
      //     .changeProfilephotoWeb(UserData.user, imgCover!);
      authRepo.updateImageWeb(
          'profilephoto', imgCover!, UserData.user!.token ?? "");
      displayMsg(context, Colors.blue, 'Changes Saved');
    } on PlatformException catch (e) {
      debugPrint("Error in pickImageWeb: ${e.toString()}");
    }
    return true;
  }

  void showDialogToChooseProfilePicture() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext c) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) => Theme(
            data: ThemeData.light(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              icon: AppBar(
                elevation: 0,
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialogToChooseInterests();
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.white,
                title: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Logo(
                    Logos.reddit,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                centerTitle: true,
              ),
              title: const Text(
                'Choose your profile photo',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                height: MediaQuery.of(c).size.height * 0.7,
                width: MediaQuery.of(c).size.width * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "This how people will see you on Reddit.\n",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "(You can change it later if you'd like)",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(c).size.height * 0.2,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: imgCover != null
                              ? ClipOval(
                                  child: InkWell(
                                    onTap: () {
                                      pickImageWeb(ImageSource.gallery)
                                          .then((value) {
                                        if (value) {
                                          setState(() {
                                            BlocProvider.of<AuthCubit>(context)
                                                .changeProfilephotoWeb(
                                                    imgCover!);
                                            displayMsg(context, Colors.blue,
                                                'Changes Saved');
                                          });
                                        }
                                      });
                                    },
                                    child: Image.memory(
                                      imgCover!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    pickImageWeb(ImageSource.gallery)
                                        .then((value) {
                                      if (value) {
                                        setState(() {
                                          BlocProvider.of<AuthCubit>(context)
                                              .changeProfilephotoWeb(imgCover!);
                                          displayMsg(context, Colors.blue,
                                              'Changes Saved');
                                        });
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 5),
                                    child: const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.black,
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
                      color: Colors.white,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(c);
                        },
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          padding:
                              MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                        ),
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
                              'Save and Continue',
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
            ),
          ),
        );
      },
    );
  }

  /// displayed in the bottom of the page on every change the user make to inform him if the change
  /// that the changes are saved or there was an error that occured
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 9,
              ),
              Logo(
                Logos.reddit,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        automaticallyImplyLeading: false,
        backgroundColor: defaultAppbarBackgroundColor,
        title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Login ||
                state is GetTheUserData ||
                state is SignedIn ||
                state is SignedInWithProfilePhoto) {
              debugPrint("state is signed in");
              return const AppBarWebLoggedIn(screen: 'Home');
            } else {
              debugPrint("state is not signed in");
              return const AppBarWebNotLoggedIn(screen: 'Home');
            }
          },
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is SignedIn) {
            debugPrint("state is signed in");
            WidgetsBinding.instance
                .addPostFrameCallback((_) => showDialogToChooseGender());
            return const HomeWeb();
          } else if (state is SignedInWithProfilePhoto) {
            debugPrint("state is SignedInWithProfilePhoto");
            UserData.profileSettings!.profile = state.imgUrl;
            debugPrint(
                "user in the home page ${UserData.profileSettings!.profile}");
            return const HomeWeb();
          } else if (state is Login) {
            return const HomeWeb();
          } else if (state is GetTheUserData) {
            if (state.userDataJson != {}) {
              debugPrint("user is nottttttttttttttttttttttttt null");
              UserData.initUser(state.userDataJson);
              return const HomeWeb();
            }
          } else if (state is NotLoggedIn) {
            return const HomeWeb();
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
