import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/widgets/nav_bars/popup_menu_logged_in.dart';
import 'package:reddit/presentation/widgets/nav_bars/popup_menu_not_logged_in.dart';

class AppBarWebNotLoggedIn extends StatefulWidget {
  final String screen;

  const AppBarWebNotLoggedIn({Key? key, required this.screen})
      : super(key: key);

  @override
  State<AppBarWebNotLoggedIn> createState() => _AppBarWebNotLoggedInState();
}

class _AppBarWebNotLoggedInState extends State<AppBarWebNotLoggedIn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, homePageRout,
              arguments: {"isLoggedIn": false}),
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              Logo(Logos.reddit, size: 30),
              const SizedBox(width: 10),
              MediaQuery.of(context).size.width < 940
                  ? const SizedBox(width: 0)
                  : const Text('reddit'),
            ],
          ),
        ),
        SizedBox(
          width: 90,
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(
                context, popularPageRout,
                arguments: {"isLoggedIn": false}),
            hoverColor: Colors.transparent,
            child: Row(
              children: [
                const Icon(Icons.arrow_circle_up_rounded, size: 27),
                const SizedBox(width: 5),
                Text(
                  widget.screen,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 0.4 * MediaQuery.of(context).size.width,
          height: 40,
          child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromRGBO(50, 50, 50, 100)),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                filled: true,
                hintText: "Search Reddit",
                isDense: true,
                hoverColor: const Color.fromRGBO(70, 70, 70, 100),
                fillColor: const Color.fromRGBO(50, 50, 50, 100),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 25,
                ),
              )),
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  side: const BorderSide(width: 1, color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            const SizedBox(width: 20),
            MediaQuery.of(context).size.width < 520
                ? const SizedBox(width: 0)
                : const PopupMenuNotLoggedIn(),
          ],
        ),
      ],
    );
  }
}
