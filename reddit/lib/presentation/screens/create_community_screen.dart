import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit/business_logic/cubit/subreddit_page_cubit.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/font_sizes.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/create_community_model.dart';
import 'package:reddit/data/repository/subreddit_page_repository.dart';
import 'package:reddit/data/web_services/subreddit_page_web_services.dart';
import 'package:reddit/presentation/screens/subreddit_screen.dart';
import '../../business_logic/cubit/create_community_cubit.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});
  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateCommunityCubit>(context).createBloc();
  }

  final bool _mobilePlatform =
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;
  late CreateCommunityModel _createCommunityModel;

  final _communityNameController = TextEditingController();
  // 0 -> no warning, 1 -> empty_name, 2 -> special_characters
  int _warningText = 0;
  final int _maxLetters = 21;
  int _remainingLetters = 21;
  int _selectedTypeIndex = 0;
  final _types = ["Public", "Private", "Restricted"];
  final _typesDescribtion = [
    "Anyone can view, post, and comment to this community",
    "Only approved users can view and submit to this community",
    "Anyone can view this community, but only approved users can post"
  ];
  final _typesIcons = [
    Icons.person,
    Icons.lock_rounded,
    Icons.remove_red_eye_outlined
  ];

  _CreateCommunityScreenState();

  void buildTypeBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: mobileTextFeildColor,
        enableDrag: true,
        context: ctx,
        builder: (_) => Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  thickness: 3,
                  indent: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width / 7) /
                      2,
                  endIndent: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width / 7) /
                      2,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Community type",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: headerFontSize,
                          fontWeight: FontWeight.w500,
                          color: lightFontColor),
                    )),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (_, index) => ListTile(
                          leading: Icon(
                            _typesIcons[index],
                            color: darkFontColor,
                          ),
                          title: Text(
                            _types[index],
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.w500,
                                color: lightFontColor),
                          ),
                          subtitle: Text(
                            _typesDescribtion[index],
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: subHeaderFontSize,
                                fontWeight: FontWeight.w400,
                                color: darkFontColor),
                          ),
                          onTap: (() {
                            _selectedTypeIndex = index;
                            BlocProvider.of<CreateCommunityCubit>(context)
                                .changeType();
                            Navigator.of(context).pop();
                          }),
                        )),
                const SizedBox(
                  height: 20,
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCommunityCubit, CreateCommunityState>(
      listener: (context, state) {
        if (state is CreateCommunityCreated) {
          BlocProvider.of<CreateCommunityCubit>(context).close();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                      create: (context) => SubredditPageCubit(
                          SubredditPageRepository(SubredditWebServices())),
                      child: SubredditPageScreen(
                        subredditId: _createCommunityModel.communityName,
                      ))));
        }
      },
      builder: (context, state) {
        if (state is CreateCommunityFailedToCreate) {
          _warningText = 4;
        }
        if (state is CreateCommunityCreateBloc) {
          _createCommunityModel = (state).createCommunityModel;
        }

        if (state is CreateCommunityNameChange) {
          if (!_mobilePlatform && _communityNameController.text.isEmpty) {
            _warningText = 1;
          } else if (!RegExp("^[a-zA-Z0-9_]{3,21}\$")
              .hasMatch(_communityNameController.text)) {
            _warningText = 2;
          } else {
            BlocProvider.of<CreateCommunityCubit>(context)
                .checkIfNameAvailable(_createCommunityModel.communityName);
            _warningText = 0;
          }
        }
        if (state is CreateCommunityNameUnAvailable) _warningText = 3;
        if (state is CreateCommunityPressed) {
          if (_warningText == 0) {
            BlocProvider.of<CreateCommunityCubit>(context)
                .createCommunity(_createCommunityModel);
          }
        }
        return _mobilePlatform
            ? Scaffold(
                backgroundColor: mobileBackgroundColor,
                appBar: AppBar(
                  backgroundColor: darkCardsColor,
                  elevation: 5,
                  title: Text("Create a community",
                      style: GoogleFonts.ibmPlexSans(
                          textStyle: const TextStyle(color: lightFontColor))),
                ),
                body: SingleChildScrollView(
                    child: Container(
                        color: darkCardsColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Community name",
                                    style: GoogleFonts.ibmPlexSans(
                                        fontSize: headerFontSize,
                                        fontWeight: FontWeight.w500,
                                        color: lightFontColor),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      style: GoogleFonts.ibmPlexSans(
                                          fontSize: subHeaderFontSize,
                                          fontWeight: FontWeight.w500,
                                          color: lightFontColor),
                                      maxLength: _maxLetters,
                                      controller: _communityNameController,
                                      onChanged: (value) {
                                        _createCommunityModel.communityName =
                                            value;
                                        _remainingLetters =
                                            _maxLetters - value.length;
                                        BlocProvider.of<CreateCommunityCubit>(
                                                context)
                                            .editName();
                                      },
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: mobileTextFeildColor,
                                                width: 0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          focusColor: mobileTextFeildColor,
                                          fillColor: mobileTextFeildColor,
                                          prefixStyle: GoogleFonts.ibmPlexSans(
                                              fontSize: subHeaderFontSize,
                                              fontWeight: FontWeight.w500,
                                              color: darkFontColor),
                                          hintStyle: GoogleFonts.ibmPlexSans(
                                              fontSize: subHeaderFontSize,
                                              fontWeight: FontWeight.w500,
                                              color: darkFontColor),
                                          prefixText: "r/",
                                          suffixText:
                                              _remainingLetters.toString(),
                                          hintText: "Community_name",
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: _showWarningText(state),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Community Type",
                                      style: GoogleFonts.ibmPlexSans(
                                          fontSize: subHeaderFontSize,
                                          fontWeight: FontWeight.w400,
                                          color: lightFontColor),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              ListTile(
                                  onTap: () => buildTypeBottomSheet(context),
                                  title: Row(
                                    children: [
                                      Text(
                                        _types[_selectedTypeIndex],
                                        style: GoogleFonts.ibmPlexSans(
                                            fontSize: headerFontSize,
                                            fontWeight: FontWeight.w500,
                                            color: lightFontColor),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: darkFontColor,
                                        size: 2 * headerFontSize,
                                      )
                                    ],
                                  ),
                                  subtitle: Text(
                                    _typesDescribtion[_selectedTypeIndex],
                                    style: GoogleFonts.ibmPlexSans(
                                        fontSize: subHeaderFontSize,
                                        fontWeight: FontWeight.w400,
                                        color: darkFontColor),
                                  )),
                              SwitchListTile(
                                inactiveThumbColor: Colors.white,
                                activeColor: Colors.white,
                                activeTrackColor: activeSwitchTrackColor,
                                value: _createCommunityModel.isAbove18,
                                onChanged: (value) {
                                  _createCommunityModel.isAbove18 = value;
                                  BlocProvider.of<CreateCommunityCubit>(context)
                                      .toggleAbove18();
                                },
                                title: Text(
                                  "18+ community",
                                  style: GoogleFonts.ibmPlexSans(
                                      fontSize: headerFontSize,
                                      fontWeight: FontWeight.w500,
                                      color: lightFontColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: _showErrorText(state),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextButton(
                                    key: const Key("create_community"),
                                    style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          35),
                                      foregroundColor: lightFontColor,
                                      backgroundColor: mobileTextFeildColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                    ),
                                    onPressed: (_communityNameController
                                            .text.isNotEmpty)
                                        ? _onPressedFunction()
                                        : null,
                                    child: Text(
                                      "Create Community",
                                      style: GoogleFonts.ibmPlexSans(
                                        fontSize: headerFontSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ))))
            : Dialog(
                backgroundColor: darkCardsColor,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xff343536), width: 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    )),
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width > 603
                        ? 530
                        : MediaQuery.of(context).size.width - 73,
                    // height: 552,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 4, 5, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              automaticallyImplyLeading: false,
                              title: Text(
                                "Create a community",
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: headerFontSize,
                                  color: lightFontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<CreateCommunityCubit>(
                                              context)
                                          .close();
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: lightFontColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const Divider(
                                height: 0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 10, 5, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Name",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: headerFontSize,
                                      color: lightFontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 5, 20),
                                child: Row(children: [
                                  Flexible(
                                    child: Text(
                                      "Community names including capitalization cannot be changed.",
                                      style: GoogleFonts.ibmPlexSans(
                                        fontSize: statementFontSize,
                                        color: darkFontColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: Icon(
                                      Icons.info_outline,
                                      color: darkFontColor,
                                      size: statementFontSize,
                                    ),
                                  )
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: TextField(
                                  maxLength: _maxLetters,
                                  controller: _communityNameController,
                                  onChanged: (value) {
                                    _createCommunityModel.communityName = value;
                                    _remainingLetters =
                                        _maxLetters - value.length;
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .editName();
                                  },
                                  decoration: const InputDecoration(
                                      fillColor: Colors.transparent,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: lightFontColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixText: "r/",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: darkFontColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "$_remainingLetters Characters remaining",
                                  style: GoogleFonts.ibmPlexSans(
                                    color: _remainingLetters == 0
                                        ? Colors.red
                                        : darkFontColor,
                                    fontSize: statementFontSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: _showWarningText(state),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 10, 5, 10),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Community Type",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: headerFontSize,
                                      color: lightFontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Colors.blue,
                                  value: "Public",
                                  groupValue:
                                      _createCommunityModel.communityType,
                                  title: Row(
                                    children: [
                                      Icon(
                                        _typesIcons[0],
                                        color: darkFontColor,
                                        size: subHeaderFontSize,
                                      ),
                                      Flexible(
                                        child: Text.rich(TextSpan(
                                            style: GoogleFonts.ibmPlexSans(
                                              fontSize: subHeaderFontSize,
                                              color: lightFontColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            text: " ${_types[0]}",
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    " ${_typesDescribtion[0]}",
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: statementFontSize,
                                                  color: darkFontColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ])),
                                      )
                                    ],
                                  ),
                                  onChanged: (value) {
                                    _createCommunityModel.communityType =
                                        value.toString();
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .changeType();
                                  }),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Colors.blue,
                                  value: "Restricted",
                                  groupValue:
                                      _createCommunityModel.communityType,
                                  title: Row(
                                    children: [
                                      Icon(_typesIcons[2],
                                          color: darkFontColor,
                                          size: subHeaderFontSize),
                                      Flexible(
                                        child: Text.rich(TextSpan(
                                            style: GoogleFonts.ibmPlexSans(
                                              fontSize: subHeaderFontSize,
                                              color: lightFontColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            text: " ${_types[2]}",
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    " ${_typesDescribtion[2]}",
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: statementFontSize,
                                                  color: darkFontColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ])),
                                      )
                                    ],
                                  ),
                                  onChanged: (value) {
                                    _createCommunityModel.communityType =
                                        value.toString();
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .changeType();
                                  }),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Colors.blue,
                                  value: "Private",
                                  groupValue:
                                      _createCommunityModel.communityType,
                                  title: Row(
                                    children: [
                                      Icon(_typesIcons[1],
                                          color: darkFontColor,
                                          size: subHeaderFontSize),
                                      Flexible(
                                        child: Text.rich(TextSpan(
                                            style: GoogleFonts.ibmPlexSans(
                                              fontSize: subHeaderFontSize,
                                              color: lightFontColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            text: " ${_types[1]}",
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    " ${_typesDescribtion[1]}",
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: statementFontSize,
                                                  color: darkFontColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ])),
                                      )
                                    ],
                                  ),
                                  onChanged: (value) {
                                    _createCommunityModel.communityType =
                                        value.toString();
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .changeType();
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 10, 5, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Adult content",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: headerFontSize,
                                      color: lightFontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                  leading: _createCommunityModel.isAbove18
                                      ? const Icon(
                                          Icons.check_box,
                                          color: Colors.blue,
                                        )
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: darkFontColor,
                                        ),
                                  onTap: () {
                                    _createCommunityModel.isAbove18 =
                                        !_createCommunityModel.isAbove18;
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .toggleAbove18();
                                  },
                                  title: Text(
                                    "18+ year old community",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: subHeaderFontSize,
                                      color: lightFontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: _showErrorText(state),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xff343536),
                          height: 60,
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                const Expanded(flex: 3, child: SizedBox()),
                                OutlinedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: (lightFontColor),
                                    side: const BorderSide(
                                        color: lightFontColor, width: 3),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<CreateCommunityCubit>(
                                            context)
                                        .close();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel",
                                      style: GoogleFonts.ibmPlexSans(
                                        fontSize: subHeaderFontSize,
                                        color: lightFontColor,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    key: const Key("create_community"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: backgroundColor,
                                      backgroundColor: lightFontColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                    ),
                                    onPressed: () {
                                      if (_communityNameController
                                          .text.isEmpty) {
                                        _warningText = 1;
                                      }
                                      BlocProvider.of<CreateCommunityCubit>(
                                              context)
                                          .createButtonPressed();
                                    },
                                    child: Text("Create Community",
                                        style: GoogleFonts.ibmPlexSans(
                                          fontSize: subHeaderFontSize,
                                          color: backgroundColor,
                                          fontWeight: FontWeight.w500,
                                        ))),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
    );
  }

  dynamic _onPressedFunction() {
    return () {
      if (_communityNameController.text.isEmpty) {
        _warningText = 1;
      }
      BlocProvider.of<CreateCommunityCubit>(context).createButtonPressed();
    };
  }

  Widget _showWarningText(CreateCommunityState state) {
    Color fontColor = _mobilePlatform ? darkFontColor : Colors.red;
    String text;
    if (_warningText == 1) {
      text = "A community name is required";
    } else if (_warningText == 2) {
      text =
          "Community names must be between 3–21 characters, and can only contain letters, numbers, or underscores.";
    } else if (_warningText == 3) {
      text =
          "Sorry, ${_createCommunityModel.communityName} is taken. Try another.";
    } else {
      return Container();
    }
    return Text(text,
        style: GoogleFonts.ibmPlexSans(
          fontSize: statementFontSize,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ));
  }

  Widget _showErrorText(state) {
    Color fontColor = _mobilePlatform ? darkFontColor : Colors.red;
    String text;
    if (_warningText == 4) {
      text = "An error occurred, please try again!!";
    } else {
      return Container();
    }
    return Text(text,
        style: GoogleFonts.ibmPlexSans(
          fontSize: statementFontSize,
          color: fontColor,
          fontWeight: FontWeight.w400,
        ));
  }
}
