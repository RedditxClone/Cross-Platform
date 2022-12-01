import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/history_page_cubit.dart';
import 'package:reddit/data/model/post_model.dart';

import '../../constants/colors.dart';

class HistoryPageScreen extends StatefulWidget {
  const HistoryPageScreen({super.key, required this.userID});
  final String userID;
  @override
  State<HistoryPageScreen> createState() => _HistoryPageScreenState();
}

class _HistoryPageScreenState extends State<HistoryPageScreen> {
  String _selectedMode = "recent";
  IconData _selectedModeIcon = Icons.timelapse_outlined;

  final bool _darkTheme = false;
  late Color _backColor;
  late Color _frontColor;
  final bool _mobilePlatform =
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;
  late String userID;
  late List<PostModel> _postModelList;
  _HistoryPageScreenState();
  @override
  void initState() {
    _backColor = _darkTheme ? const Color.fromARGB(204, 0, 0, 0) : Colors.white;
    _frontColor = _darkTheme ? Colors.white : Colors.black;

    super.initState();
    userID = widget.userID;
    BlocProvider.of<HistoryPageCubit>(context).getHistoryPage(userID, "hot");
  }

  PreferredSizeWidget? _buildAppBar() {
    return _mobilePlatform
        ? AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.list))
            ],
            title: const Text("History"),
            foregroundColor: _frontColor,
            backgroundColor: _backColor,
          )
        : null;
  }

  Widget _buildPosts() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, position) {
        return const SizedBox(
          height: 200,
          child: Card(
            color: Color.fromARGB(255, 81, 80, 80),
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
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: _frontColor,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () => _showBottomSheet(context),
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
                      color: Colors.grey,
                    )
                  ],
                ),
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
      backgroundColor: _mobilePlatform
          ? _darkTheme
              ? Colors.black
              : Colors.white
          : Colors.black,
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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: _backColor,
        enableDrag: true,
        context: context,
        builder: (_) => Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "SORT HISTORY BY",
                  style: TextStyle(color: _frontColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 4,
                ),
                ListTile(
                  leading: const Icon(Icons.timelapse_outlined),
                  title: Text(
                    "Recent",
                    style: TextStyle(color: _frontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "recent";
                    _selectedModeIcon = Icons.timelapse_outlined;
                    BlocProvider.of<HistoryPageCubit>(context)
                        .getHistoryPage(userID, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: Text(
                    "Upvoted",
                    style: TextStyle(color: _frontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "upvoted";
                    _selectedModeIcon = Icons.trending_up;
                    BlocProvider.of<HistoryPageCubit>(context)
                        .getHistoryPage(userID, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
                ListTile(
                  leading: const Icon(Icons.trending_down),
                  title: Text(
                    "Downvoted",
                    style: TextStyle(color: _frontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "downvoted";
                    _selectedModeIcon = Icons.trending_down;
                    BlocProvider.of<HistoryPageCubit>(context)
                        .getHistoryPage(userID, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
                ListTile(
                  leading: const Icon(Icons.hide_source),
                  title: Text(
                    "Hidden",
                    style: TextStyle(color: _frontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "hidden";
                    _selectedModeIcon = Icons.hide_source;
                    BlocProvider.of<HistoryPageCubit>(context)
                        .getHistoryPage(userID, _selectedMode);
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
        BlocProvider.of<HistoryPageCubit>(context).getHistoryPage(userID, mode);
      },
      icon: Icon(icon),
    );
  }
}
