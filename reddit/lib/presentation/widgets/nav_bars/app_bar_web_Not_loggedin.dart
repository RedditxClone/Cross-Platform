import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AppBarWeb extends StatefulWidget {
  const AppBarWeb({Key? key}) : super(key: key);

  @override
  State<AppBarWeb> createState() => _AppBarWebState();
}

class _AppBarWebState extends State<AppBarWeb> {
  String _screen = 'Home';
  Widget appBardIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 27,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              Logo(Logos.reddit, size: 30),
              const SizedBox(width: 10),
              const Text('reddit'),
            ],
          ),
        ),
        DropdownButton2(
            // dropdownWidth: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            buttonHeight: 40,
            buttonWidth: 300,
            buttonPadding: const EdgeInsets.only(left: 10),
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
            items: ['Home', 'Popular']
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Icon(e == 'Home'
                              ? Icons.home_filled
                              : Icons.arrow_circle_up_rounded),
                          const SizedBox(width: 10),
                          Text(e),
                        ],
                      ),
                    ))
                .toList(),
            value: _screen,
            onChanged: (val) {
              setState(() {
                _screen = val as String;
              });
            }),
        SizedBox(
          width: 400,
          height: 40,
          child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Search Reddit",
                  isDense: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                  fillColor: Colors.grey)),
        ),
        Row(
          children: [
            appBardIcon(Icons.arrow_circle_up_rounded),
            appBardIcon(Icons.circle_outlined),
            appBardIcon(Icons.message_outlined),
            appBardIcon(Icons.line_style),
            const VerticalDivider(
              width: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.white,
            ),
            appBardIcon(Icons.arrow_circle_up_rounded),
            appBardIcon(Icons.circle_outlined),
            appBardIcon(Icons.message_outlined),
            appBardIcon(Icons.notifications_outlined),
          ],
        ),
        DropdownButton2(
            // dropdownWidth: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            buttonHeight: 40,
            buttonWidth: 200,
            buttonPadding: const EdgeInsets.only(left: 10),
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
            items: ['Home', 'Popular']
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Icon(e == 'Home'
                              ? Icons.home_filled
                              : Icons.arrow_circle_up_rounded),
                          const SizedBox(width: 10),
                          Text(e),
                        ],
                      ),
                    ))
                .toList(),
            value: _screen,
            onChanged: (val) {
              setState(() {
                _screen = val as String;
              });
            }),
      ],
    );
  }
}
