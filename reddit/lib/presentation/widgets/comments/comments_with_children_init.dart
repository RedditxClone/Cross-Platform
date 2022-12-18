import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/presentation/widgets/comments/recursive_comment_with_children_widget.dart';

class CommentsWithChildrenInit extends StatelessWidget {
  Comments? commentsModel;
  CommentsWithChildrenInit({this.commentsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 13),
      child: RecursiveCommentWithChildren(commentsModel: commentsModel),
    );
  }
}
