import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit/business_logic/cubit/new_post/post_to_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';

class PostToScreen extends StatefulWidget {
  const PostToScreen({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<PostToScreen> createState() => _PostToScreenState();
}

class _PostToScreenState extends State<PostToScreen> {
  late List<SubredditModel> _joinedSubreddits = [];
  bool _enable = true;
  late PostModel _postModel;
  final _searchController = TextEditingController();
  int _selectedSubredditIndex = 0;
  bool _seeMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postModel = widget.postModel;
    BlocProvider.of<PostToCubit>(context).getUserJoinedSubreddits();
  }

  Widget _buildSubredditsList(PostToState state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _seeMore || _joinedSubreddits.length < 5
            ? _joinedSubreddits.length
            : 5,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
              _postModel.subredditId = _joinedSubreddits[index].sId!;
              _selectedSubredditIndex = index;
              Navigator.pushReplacementNamed(
                  context, postSubredditPreviewScreenRoute,
                  arguments: <String, dynamic>{
                    'post': _postModel,
                    'subreddit': _joinedSubreddits[index]
                  });
            },
            leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                foregroundImage:
                    _joinedSubreddits[_selectedSubredditIndex].icon != null
                        ? NetworkImage(
                            _joinedSubreddits[_selectedSubredditIndex].icon!,
                          )
                        : null,
                child: _joinedSubreddits[_selectedSubredditIndex].icon == null
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16,
                        child: Text(
                          "r/",
                          style: GoogleFonts.ibmPlexSans(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    : null),
            title: Text("r/${_joinedSubreddits[index].name}"),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostToCubit, PostToState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserJoinedSubredditsUploaded) {
          _joinedSubreddits = (state).userJoinedSubreddits;
        }
        return Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            title: Text(
              "Post to",
              style: GoogleFonts.ibmPlexSans(
                  color: lightFontColor,
                  fontWeight: FontWeight.w500,
                  fontSize: headerFontSize),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.close_sharp,
                color: lightFontColor,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context, _postModel),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                SizedBox(
                  child: TextField(
                    onChanged: (value) =>
                        BlocProvider.of<PostToCubit>(context).uIChanged(),
                    style: GoogleFonts.ibmPlexSans(
                        fontWeight: FontWeight.w700, color: lightFontColor),
                    decoration: InputDecoration(
                      fillColor: mobileTextFeildColor,
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: darkFontColor,
                      ),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: GoogleFonts.ibmPlexSans(
                          fontWeight: FontWeight.w700, color: darkFontColor),
                    ),
                    controller: _searchController,
                  ),
                ),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    _buildSubredditsList(state),
                    if (!_seeMore && _joinedSubreddits.length > 5)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xff368fe9), width: 1),
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 35),
                              foregroundColor: const Color(0xff368fe9),
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                            ),
                            onPressed: () {
                              _seeMore = true;
                              BlocProvider.of<PostToCubit>(context).uIChanged();
                            },
                            child: Text(
                              "See more",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
