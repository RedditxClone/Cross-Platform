import 'package:flutter/material.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 300,
      child: Column(
        children: [
          Container(
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Icon(
                  Icons.person_pin,
                  size: 100,
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("u/bemoierian"),
                      Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    width: 150,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                        Text(
                          "Online status: On",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 300,
                  // color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 300,
                // color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text("My profile"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text("Create a community"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.save_alt_sharp),
                      label: const Text("Saved"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.history_outlined),
                      label: const Text("History"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.paste_outlined),
                      label: const Text("Pending posts"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 300,
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.paste_outlined),
                  label: const Text("Settings"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
