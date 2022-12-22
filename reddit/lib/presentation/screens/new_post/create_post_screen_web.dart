import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/new_post/create_post_cubit.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:zefyrka/zefyrka.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/strings.dart';
import '../../../constants/theme_colors.dart';
import '../../../data/model/auth_model.dart';
import '../../widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import '../../widgets/nav_bars/app_bar_web_loggedin.dart';

class CreatePostScreenWeb extends StatefulWidget {
  const CreatePostScreenWeb({super.key});

  @override
  State<CreatePostScreenWeb> createState() => _CreatePostScreenWebState();
}

class _CreatePostScreenWebState extends State<CreatePostScreenWeb> {
  bool _validURL = false;

  var _picker;

  var _pickedImage;
  _selectedType() {
    switch (_selectedTypeIndex) {
      case 0:
        return _pickImage();
      case 1:
        return _pickVideo();
      case 2:
        return _textBody();
      case 3:
        return _insertURL();
      default:
        return Container();
    }
  }

  _fetchImage() async {}

  _pickImage() {}

  _pickVideo() {}

  _textBody() {
    return TextField(
      style: GoogleFonts.ibmPlexSans(
          fontSize: headerFontSize,
          fontWeight: FontWeight.w500,
          color: lightFontColor),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "body text (optional)",
        hintStyle: GoogleFonts.ibmPlexSans(
            fontSize: headerFontSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xff898d90)),
      ),
      controller: _bodyController,
      onChanged: (value) {
        BlocProvider.of<CreatePostCubit>(context).uIChanged();
      },
      maxLines: null,
    );
  }

  _insertURL() {
    return SizedBox(
      child: TextField(
        onChanged: (value) {
          _validURL = Uri.parse(_urlController.text).host.isNotEmpty;
          BlocProvider.of<CreatePostCubit>(context).uIChanged();
        },
        style: GoogleFonts.ibmPlexSans(
            fontSize: headerFontSize,
            fontWeight: FontWeight.w500,
            color: lightFontColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "URL",
          hintStyle: GoogleFonts.ibmPlexSans(
              fontSize: headerFontSize,
              fontWeight: FontWeight.w500,
              color: const Color(0xff898d90)),
        ),
        controller: _urlController,
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
      int index, IconData iSelected, IconData iNotselected) {
    return BottomNavigationBarItem(
        icon: Icon((_selectedTypeIndex == index) ? iSelected : iNotselected,
            size: 33),
        label: "");
  }

  bool _enable = false;
  int _selectedTypeIndex = 2;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final ZefyrController _zefyrController = ZefyrController();
  PostModel _postModel = PostModel(
      subredditId: "",
      title: "",
      text: "",
      nsfw: false,
      spoiler: false,
      flair: "",
      publishedDate: DateTime.now());
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreatePostCubit>(context).createBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
          listener: (context, state) async {
        if (state is NextButtonPressed) {
          _postModel.title = _titleController.text.toString();
          _postModel.text = _selectedTypeIndex == 2
              ? _bodyController.text.toString()
              : _urlController.text.toString();
          Navigator.pushNamed(context, postToMobileScreenRoute,
              arguments: _postModel);
        }
      }, builder: (context, state) {
        _enable = _selectedTypeIndex == 2 && _titleController.text.isNotEmpty ||
            _selectedTypeIndex == 3 &&
                _validURL &&
                _titleController.text.isNotEmpty;
        return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
          var width = constraints.maxWidth;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width > 900 ? (width - 870) / 2 : 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child:
                        // (state is PostsInPageLoading)
                        // ? const Center(
                        // child: CircularProgressIndicator(
                        // color: darkFontColor),
                        // )
                        // :
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 2, bottom: 10.0),
                              child: Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      color: cardsColor,
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Column(
                                    children: [
                                      ZefyrToolbar.basic(
                                          controller: _zefyrController),
                                      ZefyrEditor(
                                        controller: _zefyrController,
                                      ),
                                    ],
                                  ))),
                          // Column(
                          //   children: [
                          //     ZefyrToolbar.basic(controller: _zefyrController),
                          //     ZefyrEditor(
                          //       controller: _zefyrController,
                          //     ),
                          //   ],
                          // )
                        ])),
                width > 700
                    ? Expanded(flex: 1, child: Text("user card"))
                    : Container()
              ],
            ),
          );
        }));
        // return
        // Center(
        //     child: Column(
        //   children: [
        //     ZefyrToolbar.basic(controller: _zefyrController),
        //     Expanded(
        //       child: ZefyrEditor(
        //         controller: _zefyrController,
        //       ),
        //     ),
        //   ],
        // ))
        // ;
      }),
    );
  }

  _buildAppBar() {
    return AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
        automaticallyImplyLeading: false,
        backgroundColor: defaultAppbarBackgroundColor,
        title: UserData.user != null
            ? const AppBarWebLoggedIn(screen: 'Create Post')
            : const AppBarWebNotLoggedIn(screen: 'Create Post'));
  }
}
