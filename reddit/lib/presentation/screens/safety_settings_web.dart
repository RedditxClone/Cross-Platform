import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetySettingsWeb extends StatefulWidget {
  const SafetySettingsWeb({Key? key}) : super(key: key);

  @override
  State<SafetySettingsWeb> createState() => _SafetySettingsWebState();
}

class _SafetySettingsWebState extends State<SafetySettingsWeb> {
  Settings? safetySettings;
  TextEditingController blockedUsers = TextEditingController();
  late Responsive responsive;
  String disruptiveComments = 'OFF';
  Color _AddColor = Colors.grey;
  bool var1 = true;
  bool var2 = true;
  bool var3 = true;
  bool var4 = true;
  bool var5 = true;
  bool var6 = true;
  bool var7 = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsCubit>(context).getUserSettings();
  }

  TextSpan createTextSpan(String txt, bool isUrl) {
    return TextSpan(
      text: txt,
      style: TextStyle(
        fontSize: 12,
        color: isUrl ? Colors.blue : Colors.grey,
        decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (isUrl) {
            launchUrl(Uri.parse(
                'https://www.reddithelp.com/hc/en-us/categories/360003246511'));
          }
        },
    );
  }

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
              SizedBox(width: 10),
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

  Widget buildBody() {
    return Row(
      children: [
        Expanded(
            flex: responsive.isSmallSizedScreen() ? 0 : 1,
            child: const SizedBox(width: 10)),
        Expanded(
          flex: responsive.isMediumSizedScreen() ? 4 : 3,
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
                  onSubmitted: (value) {
                    BlocProvider.of<SettingsCubit>(context)
                        .updateSettings({'blocked': value});
                    displayMsg(context, Colors.blue, 'Changes Saved');
                  },
                  controller: blockedUsers,
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffix: TextButton(
                        onHover: (isHoverd) {
                          setState(() {
                            _AddColor = isHoverd ? Colors.white : Colors.grey;
                          });
                        },
                        onPressed: () {
                          //if(){ // if the user added exist
                          // BlocProvider.of<SettingsCubit>(context)
                          //     .updateSettings({'blocked': blockedUsers.text});
                          // displayMsg(context, Colors.blue, '${blockedUsers.text} is now blocked');
                          //}
                          //else{
                          displayMsg(context, Colors.red,
                              'An error has occured. Please try again later');
                          //}
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 16, color: _AddColor),
                        )),
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
                      items: ['OFF', 'LOW', 'MEDIUM', 'HIGH']
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: safetySettings!.disroptiveSettings,
                      onChanged: (val) {
                        setState(() {
                          safetySettings!.disroptiveSettings = val as String;
                          disruptiveComments = val;
                          BlocProvider.of<SettingsCubit>(context)
                              .updateSettings({'disruptiveComments': val});
                          displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.showUnInSearch,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.showUnInSearch = var1 = newValue;
                    BlocProvider.of<SettingsCubit>(context)
                        .updateSettings({'showUnInSearch': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.personalizeAllOfReddit,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.personalizeAllOfReddit = var2 = newValue;
                    BlocProvider.of<SettingsCubit>(context)
                        .updateSettings({'personalizeAllOfReddit': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.personalizeAdsInformation,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.personalizeAdsInformation = var3 = newValue;
                    BlocProvider.of<SettingsCubit>(context).updateSettings(
                        {'personalizeAdsInformation': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.personalizeAdsYourActivity,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.personalizeAdsYourActivity =
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
                value: safetySettings!.personalizeRecGeneralLocation,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.personalizeRecGeneralLocation =
                        var5 = newValue;
                    BlocProvider.of<SettingsCubit>(context).updateSettings(
                        {'personalizeRecGeneralLocation': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.personalizeRecOurPartners,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.personalizeRecOurPartners = var6 = newValue;
                    BlocProvider.of<SettingsCubit>(context).updateSettings(
                        {'personalizeRecOurPartners': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
                value: safetySettings!.useTwoFactorAuthentication,
                onChanged: (newValue) {
                  setState(() {
                    safetySettings!.useTwoFactorAuthentication =
                        var7 = newValue;
                    BlocProvider.of<SettingsCubit>(context).updateSettings(
                        {'useTwoFactorAuthentication': newValue});
                    displayMsg(context, Colors.blue, 'Changes Saved');
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
        Expanded(
            flex: responsive.isSmallSizedScreen()
                ? 0
                : responsive.isMediumSizedScreen()
                    ? 1
                    : responsive.isLargeSizedScreen()
                        ? 2
                        : 3,
            child: const SizedBox(width: 10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsAvailable) {
              responsive = Responsive(context);
              safetySettings = state.settings;
              blockedUsers =
                  TextEditingController(text: safetySettings!.blocked);
              return buildBody();
            } else if (state is SettingsChanged) {
              safetySettings = state.settings;
              return buildBody();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
