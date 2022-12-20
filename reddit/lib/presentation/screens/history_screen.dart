import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/history_page_cubit.dart';
import 'package:reddit/data/model/post_model.dart';

import '../../constants/colors.dart';
import '../../constants/font_sizes.dart';

class HistoryPageScreen extends StatefulWidget {
  const HistoryPageScreen({super.key});
  @override
  State<HistoryPageScreen> createState() => _HistoryPageScreenState();
}

class _HistoryPageScreenState extends State<HistoryPageScreen> {
  bool _emptyList = false;
  String _selectedMode = "recent";
  bool _classicView = false;
  IconData _selectedModeIcon = Icons.timelapse_outlined;

  final bool _mobilePlatform =
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;
  late List<PostModel> _postModelList;
  _HistoryPageScreenState();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryPageCubit>(context)
        .getHistoryPage("upvoted");
  }

  PreferredSizeWidget? _buildAppBar() {
    return _mobilePlatform
        ? AppBar(
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          height: 20,
                          onTap: () {
                            _emptyList = true;
                            BlocProvider.of<HistoryPageCubit>(context)
                                .changeUI();
                          },
                          child: Container(
                            child: Row(children: const [
                              Icon(
                                Icons.cancel_outlined,
                                color: lightFontColor,
                              ),
                              Text(
                                "Clear history",
                                style: TextStyle(color: lightFontColor),
                              )
                            ]),
                          ),
                        )
                      ],
                  icon: const Icon(Icons.list))
            ],
            title: const Text("History"),
            foregroundColor: lightFontColor,
            backgroundColor: mobileCardsColor,
          )
        : null;
  }

  Widget _buildPosts() {
    if (_emptyList) return Container();
    if (_classicView) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, position) {
          return Container(
            color: _mobilePlatform ? mobileCardsColor : cardsColor,
            child: Column(
              children: [
                for (int i = 0; i < 5; i++)
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      if (i != 4)
                        const Divider(
                          thickness: 2,
                        )
                    ],
                  ),
              ],
            ),
          );
        },
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, position) {
        return SizedBox(
          height: 100,
          child: Card(
            color: _mobilePlatform ? mobileCardsColor : cardsColor,
          ),
        );
      },
    );
  }

  Widget _buildBody(HistoryPageState state) {
    return _mobilePlatform
        ? SingleChildScrollView(
            child: Column(children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: darkFontColor,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () => _showBottomSheet(context, true),
                    child: Row(
                      children: [
                        Icon(_selectedModeIcon),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(_selectedMode),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: darkFontColor,
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _classicView
                          ? Icons.view_list
                          : Icons.crop_square_outlined,
                      color: darkFontColor,
                    ),
                    onPressed: () {
                      _showBottomSheet(context, false);
                    },
                  )
                ],
              ),
            ),
            _buildPosts()
          ]))
        : SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              child: Expanded(
                flex: 3,
                child: Column(children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: cardsColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: Row(children: [
                      const SizedBox(
                        width: 8,
                      ),
                      _createButtons(
                          'Recent', Icons.timelapse_outlined, 'recent'),
                      const SizedBox(
                        width: 4,
                      ),
                      _createButtons('Upvoted', Icons.trending_up, 'upvoted'),
                      const SizedBox(
                        width: 4,
                      ),
                      _createButtons(
                          'Downvoted', Icons.trending_down, 'downvoted'),
                      const SizedBox(
                        width: 4,
                      ),
                      _createButtons('Hidden', Icons.hide_source, 'hidden'),
                    ]),
                  ),
                  _buildPosts(),
                ]),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _mobilePlatform ? mobileBackgroundColor : backgroundColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<HistoryPageCubit, HistoryPageState>(
          builder: (context, state) {
        if (state is HistoryPagePostsLoaded) {
          _postModelList = (state).subredditsInPageModels;
        }
        return _buildBody(state);
      }),
    );
  }

  _showBottomSheet(BuildContext context, bool ifPosts) {
    showModalBottomSheet(
        backgroundColor: mobileTextFeildColor,
        enableDrag: true,
        context: context,
        builder: (_) => Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ifPosts ? "SORT HISTORY BY" : "POST VIEW",
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: subHeaderFontSize,
                      fontWeight: FontWeight.w500,
                      color: darkFontColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                    trailing: (_selectedMode == "recent") && ifPosts
                        ? const Icon(
                            Icons.check_sharp,
                            color: Colors.blue,
                          )
                        : null,
                    leading: Icon(
                        ifPosts
                            ? Icons.timelapse_outlined
                            : Icons.crop_square_outlined,
                        color: ifPosts && _selectedMode == "recent" ||
                                !ifPosts && !_classicView
                            ? lightFontColor
                            : darkFontColor),
                    title: Text(
                      ifPosts ? "Recent" : "Card",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: subHeaderFontSize,
                          fontWeight: FontWeight.w500,
                          color: ifPosts && _selectedMode == "recent" ||
                                  !ifPosts && !_classicView
                              ? lightFontColor
                              : darkFontColor),
                    ),
                    onTap: ifPosts
                        ? () {
                            _selectedMode = "recent";
                            _selectedModeIcon = Icons.timelapse_outlined;
                            BlocProvider.of<HistoryPageCubit>(context)
                                .getHistoryPage( _selectedMode);
                            Navigator.of(context).pop();
                          }
                        : () {
                            _classicView = false;
                            BlocProvider.of<HistoryPageCubit>(context)
                                .changeUI();
                            Navigator.of(context).pop();
                          }),
                ListTile(
                    trailing: (_selectedMode == "upvoted") && ifPosts
                        ? const Icon(
                            Icons.check_sharp,
                            color: Colors.blue,
                          )
                        : null,
                    leading: Icon(ifPosts ? Icons.trending_up : Icons.view_list,
                        color: ifPosts && _selectedMode == "upvoted" ||
                                !ifPosts && _classicView
                            ? lightFontColor
                            : darkFontColor),
                    title: Text(
                      ifPosts ? "Upvoted" : "Classic",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: subHeaderFontSize,
                          fontWeight: FontWeight.w500,
                          color: ifPosts && _selectedMode == "upvoted" ||
                                  !ifPosts && _classicView
                              ? lightFontColor
                              : darkFontColor),
                    ),
                    onTap: ifPosts
                        ? () {
                            _selectedMode = "upvoted";
                            _selectedModeIcon = Icons.trending_up;
                            BlocProvider.of<HistoryPageCubit>(context)
                                .getHistoryPage( _selectedMode);
                            Navigator.of(context).pop();
                          }
                        : () {
                            _classicView = true;
                            BlocProvider.of<HistoryPageCubit>(context)
                                .changeUI();
                            Navigator.of(context).pop();
                          }),
                if (ifPosts)
                  ListTile(
                    trailing: (_selectedMode == "downvoted")
                        ? const Icon(
                            Icons.check_sharp,
                            color: Colors.blue,
                          )
                        : null,
                    leading: Icon(Icons.trending_down,
                        color: (_selectedMode == "downvoted")
                            ? lightFontColor
                            : darkFontColor),
                    title: Text(
                      "Downvoted",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: subHeaderFontSize,
                          fontWeight: FontWeight.w500,
                          color: _selectedMode == "downvoted"
                              ? lightFontColor
                              : darkFontColor),
                    ),
                    onTap: (() {
                      _selectedMode = "downvoted";
                      _selectedModeIcon = Icons.trending_down;
                      BlocProvider.of<HistoryPageCubit>(context)
                          .getHistoryPage( _selectedMode);
                      Navigator.of(context).pop();
                    }),
                  ),
                if (ifPosts)
                  ListTile(
                    trailing: (_selectedMode == "hidden")
                        ? const Icon(
                            Icons.check_sharp,
                            color: Colors.blue,
                          )
                        : null,
                    leading: Icon(Icons.hide_source,
                        color: (_selectedMode == "hidden")
                            ? lightFontColor
                            : darkFontColor),
                    title: Text(
                      "Hidden",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: subHeaderFontSize,
                          fontWeight: FontWeight.w500,
                          color: _selectedMode == "hidden"
                              ? lightFontColor
                              : darkFontColor),
                    ),
                    onTap: (() {
                      _selectedMode = "hidden";
                      _selectedModeIcon = Icons.hide_source;
                      BlocProvider.of<HistoryPageCubit>(context)
                          .getHistoryPage( _selectedMode);
                      Navigator.of(context).pop();
                    }),
                  ),
              ],
            )));
  }

  _createButtons(String title, IconData icon, String mode) {
    return TextButton.icon(
      label: Text(title),
      style: IconButton.styleFrom(
        foregroundColor: _selectedMode == mode ? lightFontColor : darkFontColor,
        backgroundColor:
            _selectedMode == mode ? textFeildColor : Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
      ),
      onPressed: () {
        _selectedMode = mode;
        _selectedModeIcon = icon;
        BlocProvider.of<HistoryPageCubit>(context).getHistoryPage( mode);
      },
      icon: Icon(icon),
    );
  }
}
