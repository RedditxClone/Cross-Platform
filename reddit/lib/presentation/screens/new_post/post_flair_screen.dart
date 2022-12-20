import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit/business_logic/cubit/new_post/post_flair_cubit.dart';
import 'package:reddit/data/model/post_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/strings.dart';
import '../../../data/model/flair_model.dart';
import '../../../data/model/subreddit_model.dart';

class PostFlairScreen extends StatefulWidget {
  final List<FlairModel> flairList;
  const PostFlairScreen({super.key, required this.flairList});

  @override
  State<PostFlairScreen> createState() => _PostFlairScreenState();
}

class _PostFlairScreenState extends State<PostFlairScreen> {
  String _selectedFId = "";
  int _groupValue = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostFlairCubit>(context).createBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostFlairCubit, PostFlairState>(
      listener: (context, state) async {
        if (state is CancelButtonPressed) {
          Navigator.pop(context, "");
        }
        if (state is ApplyButtonPressed) {
          Navigator.pop(context, _selectedFId);
        }
      },
      builder: (context, state) {
        if (state is FlairChanged) {
          if (_groupValue == 0) {
            _selectedFId = "";
          } else {
            _selectedFId = widget.flairList[_groupValue - 1].fId;
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => BlocProvider.of<PostFlairCubit>(context)
                  .cancelButtonPressed(),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text("Post Flair"),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(children: [
                for (int i = 0; i < widget.flairList.length; i++)
                  RadioListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.blue,
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: UnconstrainedBox(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            widget.flairList[i].text,
                            style: const TextStyle(
                                fontSize: statementFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    groupValue: _groupValue,
                    value: i + 1,
                    onChanged: (value) {
                      _groupValue = value as int;

                      BlocProvider.of<PostFlairCubit>(context).flairChanged();
                    },
                  ),
              ]))),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: darkFontColor,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () => BlocProvider.of<PostFlairCubit>(context)
                          .cancelButtonPressed(),
                      child: const Text("Cancel")),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: lightFontColor,
                        backgroundColor: const Color(0xff368fe9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text("Apply"),
                    onPressed: () {
                      BlocProvider.of<PostFlairCubit>(context)
                          .applyButtonPressed();
                    },
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
