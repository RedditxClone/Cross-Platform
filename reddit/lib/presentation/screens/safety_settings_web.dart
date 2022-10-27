import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SafetySettingsWeb extends StatefulWidget {
  const SafetySettingsWeb({Key? key}) : super(key: key);

  @override
  State<SafetySettingsWeb> createState() => _SafetySettingsWebState();
}

class _SafetySettingsWebState extends State<SafetySettingsWeb> {
  String disruptiveComments = 'OFF';
  bool var1 = true;
  bool var2 = true;
  bool var3 = true;
  bool var4 = true;
  bool var5 = true;
  bool var6 = true;
  bool var7 = true;

  TextSpan createTextSpan(String txt, bool isUrl) {
    return TextSpan(
      text: txt,
      style: TextStyle(
        fontSize: 12,
        color: isUrl ? Colors.blue : Colors.grey,
        decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
      ),
      recognizer: TapGestureRecognizer()..onTap = () {},
    );
  }

  Widget title(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(170, 20, 670, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Safety & Privacy',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              RichText(
                  text: TextSpan(children: [
                createTextSpan(
                    'Manage how we use data to personalize your Reddit experience, and control how other redditors interact with you. To learn more, visit our ',
                    false),
                createTextSpan('Privacy & Security FAQs .', true),
              ])),
              const SizedBox(height: 20),

              /////////////////---SAFETY--//////////////////////
              const Text('SAFETY',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              const Divider(),

              //------------- People You’ve Blocked--------------
              title('People You’ve Blocked',
                  'Blocked people can’t send you chat requests or private messages.'),
              TextField(
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixText: 'Add',
                    suffixStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3)),
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Block new user',
                    hintStyle: const TextStyle(fontSize: 13),
                  )),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: title('Collapse potentially disruptive comments',
                        'Automatically collapse comments that are potentially rude or disrespectful by selecting the sensitivity level you\'re most comfortable with—selecting Low will collapse the least, High will collapse the most.'),
                  ),
                  DropdownButton(
                      alignment: Alignment.center,
                      underline: const SizedBox(),
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                      value: disruptiveComments,
                      items: ['OFF', 'LOW', 'MEDIUM', 'HIGH']
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          disruptiveComments = val as String;
                        });
                      })
                ],
              ),
              const SizedBox(height: 25),
              /////////////////---PRIVACY--//////////////////////
              const Text('PRIVACY',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              const Divider(),
              //------------- Show up in search results --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var1,
                onChanged: (newValue) {
                  setState(() {
                    var1 = newValue;
                  });
                },
                title: const Text('Show up in search results',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow search engines like Google to link to your profile in their search results.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              //------------- Personalize all of Reddit based on the outbound links you click on --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var2,
                onChanged: (newValue) {
                  setState(() {
                    var2 = newValue;
                  });
                },
                title: const Text(
                    'Personalize all of Reddit based on the outbound links you click on',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow us to use the links to other sites you click on for operational purposes (that help us better \nunderstand how you and others use Reddit) and to show you better ads and recommendations.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              //------------- Personalize ads based on information from our partners --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var3,
                onChanged: (newValue) {
                  setState(() {
                    var3 = newValue;
                  });
                },
                title: const Text(
                    'Personalize ads based on information from our partners',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow us to use information that our advertising partners send us to show you better ads.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              //------------- Personalize ads based on your activity with our partners --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var4,
                onChanged: (newValue) {
                  setState(() {
                    var4 = newValue;
                  });
                },
                title: const Text(
                    'Personalize ads based on your activity with our partners',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow us to use your interactions with sites and apps we partner with to show you better ads.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              //------------- Personalize recommendations based on your general location --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var5,
                onChanged: (newValue) {
                  setState(() {
                    var5 = newValue;
                  });
                },
                title: const Text(
                    'Personalize recommendations based on your general location',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow us to use your city, state, or country (based on your IP) to recommend better posts and communities.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              //------------- Personalize recommendations based on your activity with our partners --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var6,
                onChanged: (newValue) {
                  setState(() {
                    var6 = newValue;
                  });
                },
                title: const Text(
                    'Personalize recommendations based on your activity with our partners',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Allow us to use your interactions with sites and apps we partner with to recommend better posts and communities.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 50),
              /////////////////---ADVANCED SECURITY--//////////////////////
              const Text('ADVANCED SECURITY',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              const Divider(),
              //------------- Use two-factor authentication --------------
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: var7,
                onChanged: (newValue) {
                  setState(() {
                    var7 = newValue;
                  });
                },
                title: const Text('Use two-factor authentication',
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text(
                    'Help protect your account (even if someone gets your password) by requiring a verification code and a password to log in.',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
