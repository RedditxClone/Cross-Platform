import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/presentation/widgets/comments/comment_widget.dart';

class RecursiveCommentWithChildren extends StatelessWidget {
  Comments? commentsModel;
  RecursiveCommentWithChildren({this.commentsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      // width: 200,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 13),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CommentWidget(
                  commentsModel: commentsModel,
                ),
              ),
            ],
          ),
          commentsModel!.children != null && commentsModel!.children!.isNotEmpty
              ? Column(
                  children: [
                    ...commentsModel!.children!.map((e) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1))),
                              child: RecursiveCommentWithChildren(
                                  commentsModel: e),
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
