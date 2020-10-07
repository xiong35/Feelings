import 'package:feelings/components/musicItem.dart';
import 'package:feelings/global/requests.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  SearchRes res;

  List<Widget> get songs => res == null
      ? []
      : res.result.songs
          .map((e) => MusicItem(song: e, curPlaylist: [e.id]))
          .toList();

  @override
  void didChangeDependencies() {
    if (res == null) {
      Map<String, dynamic> args =
          ModalRoute.of(context).settings.arguments ??
              {"kw": ""};

      String kw = args["kw"];

      Requests.getSearchRes(kw)
          .then((value) => setState(() => res = value));
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
          "??",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: ListView(
        children: songs,
      ),
    );
  }
}
