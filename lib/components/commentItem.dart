import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key key, this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(comment.user.nickname),
          subtitle: Text(
            formatTime(comment.time),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: ImgPlaceHolder(
              url: comment.user.avatarUrl,
              height: 50,
              width: 50,
            ),
          ),
          trailing: Text("${comment.likedCount}👍"),
        ),
        Row(
          children: [
            SizedBox(
              width: 70,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
                child: Text(
                  comment.content,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
        PartDevider()
      ],
    );
  }
}
