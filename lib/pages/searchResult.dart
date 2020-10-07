import 'package:feelings/components/musicItem.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/requests.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';

const LIMIT = 10;

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  SearchRes res;
  ScrollController _scrollController = new ScrollController();
  String kw;
  num curPage = 0;

  List<Widget> get songs => res == null
      ? []
      : res.result.songs
          .map((e) => MusicItem(song: e, curPlaylist: [e.id]))
          .toList();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 70) {
        getMore();
      }
    });
  }

  getMore() async {
    SearchRes newRes =
        await Requests.getSearchRes(kw, LIMIT, curPage * LIMIT);
    setState(() {
      if (res == null)
        res = newRes;
      else
        res.result.songs.addAll(newRes.result.songs);
      curPage += 1;
    });
  }

  @override
  void didChangeDependencies() {
    if (kw == null) {
      Map<String, dynamic> args =
          ModalRoute.of(context).settings.arguments ??
              {"kw": ""};

      kw = args["kw"];
      getMore();
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
          '"$kw" ' +
              FeelingsLocalization.of(context).searchResHint,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: ListView(
        controller: _scrollController,
        children: songs,
      ),
    );
  }
}
