import 'package:feelings/components/commentItem.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/requests.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';

class MusicComment extends StatefulWidget {
  MusicComment({Key key}) : super(key: key);

  @override
  _MusicCommentState createState() => _MusicCommentState();
}

class _MusicCommentState extends State<MusicComment> {
  SearchRes res;
  String id;
  List<Comment> _comments;
  String name;
  List<Widget> get comments => _comments == null
      ? []
      : _comments
          .map(
            (e) => CommentItem(
              comment: e,
            ),
          )
          .toList();

  @override
  void didChangeDependencies() {
    if (id == null) {
      Map<String, dynamic> args =
          ModalRoute.of(context).settings.arguments ??
              {"id": "0", "name": ""};

      id = args["id"].toString();
      name = args["name"];
      Requests.getCommentById(id).then(
        (value) => setState(() => _comments = value),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.background,
        title: Text(
          "$name " + FeelingsLocalization.of(context).comment,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: ListView(
        children: comments,
      ),
    );
  }
}
