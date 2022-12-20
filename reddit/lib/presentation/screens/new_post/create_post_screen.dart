import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/new_post/create_post_cubit.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/presentation/screens/new_post/post_to_mobile.dart';
import 'package:zefyrka/zefyrka.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/strings.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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

  _fetchImage() async {
    // Pick an image
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      _pickedImage = await image.readAsBytes();
    } catch (e) {
      print(e);
    }
  }

  _pickImage() {
    _fetchImage();
    return Container();
  }

  _pickVideo() {
    return Container(
      color: Colors.amber,
    );
  }

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
          print("valid url" + _validURL.toString());
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
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      listener: (context, state) async {
        if (state is NextButtonPressed) {
          _postModel.title = _titleController.text.toString();
          _postModel.text = _selectedTypeIndex == 2
              ? _bodyController.text.toString()
              : _urlController.text.toString();
          Navigator.pushNamed(context, postToMobileScreenRoute,
              arguments: _postModel);
        }
      },
      builder: (context, state) {
        _enable = _selectedTypeIndex == 2 && _titleController.text.isNotEmpty ||
            _selectedTypeIndex == 3 &&
                _validURL &&
                _titleController.text.isNotEmpty;

        return kIsWeb
            ? Center(
                child: Column(
                children: [
                  ZefyrToolbar.basic(controller: _zefyrController),
                  Expanded(
                    child: ZefyrEditor(
                      controller: _zefyrController,
                    ),
                  ),
                ],
              ))
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_sharp,
                      color: lightFontColor,
                      size: 30,
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 10, 8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: lightFontColor,
                          backgroundColor:
                              _enable ? const Color(0xff368fe9) : cardsColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                        ),
                        onPressed: _enable
                            ? () {
                                BlocProvider.of<CreatePostCubit>(context)
                                    .nextButtonPressed();
                              }
                            : null,
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            BlocProvider.of<CreatePostCubit>(context)
                                .uIChanged();
                          },
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: lightFontColor),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: GoogleFonts.ibmPlexSans(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff898d90)),
                          ),
                          controller: _titleController,
                        ),
                      ),
                      _selectedType() as Widget
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.black,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    currentIndex: _selectedTypeIndex,
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      _selectedTypeIndex = value;
                      setState(() {});
                    },
                    items: [
                      bottomNavBarItem(0, Icons.photo, Icons.photo_outlined),
                      bottomNavBarItem(1, Icons.video_collection,
                          Icons.video_collection_outlined),
                      bottomNavBarItem(
                          2, Icons.article, Icons.article_outlined),
                      bottomNavBarItem(3, Icons.link, Icons.link_outlined),
                    ]),
              );
      },
    );
  }
}
