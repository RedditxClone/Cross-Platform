import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/constants/strings.dart';
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
          onTap: () => Navigator.pushReplacementNamed(context, homePageRoute,
              arguments: null),
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Logo(Logos.reddit, color: Colors.white, size: 30)),
              const SizedBox(width: 10),
              MediaQuery.of(context).size.width < 940
                  ? const SizedBox(width: 0)
                  : const Text('reddit'),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: InkWell(
            onTap: () => Navigator.pushReplacementNamed(
                context, popularPageRoute,
                arguments: null),
            hoverColor: Colors.transparent,
            child: Row(
              children: [
                const Icon(Icons.arrow_circle_up_rounded, size: 25),
                const SizedBox(width: 4),
                MediaQuery.of(context).size.width > 1000
                    ? Text(
                        widget.screen,
                        style: const TextStyle(fontSize: 13),
                      )
                    : const SizedBox(width: 0)
              ],
            ),
          ),
        ),
        SizedBox(
          width: 0.38 * MediaQuery.of(context).size.width,
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
            MediaQuery.of(context).size.width > 800
                ? OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, SIGNU_PAGE1),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        side: const BorderSide(width: 1, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : const SizedBox(width: 0),
            const SizedBox(width: 20),
            MediaQuery.of(context).size.width > 800
                ? ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, loginPage),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                : const SizedBox(width: 0),
            SizedBox(width: MediaQuery.of(context).size.width < 600 ? 20 : 10),
            const PopupMenuNotLoggedIn(),
          ],
        ),
      ],
    );
  }
}
