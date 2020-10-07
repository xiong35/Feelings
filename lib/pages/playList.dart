import 'dart:convert';
import 'dart:math';

import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/components/loading.dart';
import 'package:feelings/pages/musicPlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/thePlayPanel.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/models/index.dart';
import 'package:feelings/global/requests.dart';

const PER_PAGE = 10;

class PlaylistView extends StatefulWidget {
  PlaylistView({Key key, num limit}) : super(key: key);

  final num limit = 999;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  ScrollController _scrollController = new ScrollController();

  PlaylistContentData _playlistContentData;

  List<num> get songIds =>
      _playlistContentData?.trackIds
          ?.map((e) => e.id)
          ?.toList() ??
      [];

  List<String> get newIds {
    num begin = min(curPage * PER_PAGE, songIds.length);
    num end = min(songIds.length, begin + PER_PAGE);
    return songIds
        .sublist(begin, end)
        .map((e) => "$e")
        .toList();
  }

  List<Widget> get songs {
    if (!haveData) {
      if (curId != null)
        Requests.getPlaylistContentData(curId).then((value) =>
            setState(() => _playlistContentData = value));
      return [
        for (num i = 0; i < 3; i++) MusicItem(),
      ];
    }
    return _playlistContentData.tracks
        .map((e) => MusicItem(
              song: e,
              curPlaylist: songIds,
            ))
        .toList();
  }

  bool get haveData => _playlistContentData != null;

  String curId;
  num curPage = 1;

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
    List<Song> newSongs = await Requests.getSongDetail(newIds);
    setState(() {
      _playlistContentData.tracks.addAll(newSongs);
      curPage += 1;
    });
  }

  playAll(BuildContext context) {
    Provider.of<MusicPlayModel>(context, listen: false)
        .refreshById(-1, songIds);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;

    curId = "${args['id']}";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      bottomNavigationBar: ThePlayPanel(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          FeelingsLocalization.of(context).playlistTitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: Loading(
        isLoading: !haveData,
        child: ListView(
          controller: _scrollController,
          children: [
            PlaylistProfile(
                id: args["id"], data: _playlistContentData),
            PartDevider(),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.play_arrow_outlined),
                onPressed: () => playAll(context),
                color: Theme.of(context)
                    .colorScheme
                    .secondaryVariant,
                iconSize: 30,
              ),
              title: Text(
                FeelingsLocalization.of(context)
                    .playlistPlayAll,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () => playAll(context),
            ),
            ListView(
              shrinkWrap: true,
              children: songs,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistProfile extends StatelessWidget {
  const PlaylistProfile({Key key, this.id, this.data})
      : super(key: key);

  final num id;
  final PlaylistContentData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImgPlaceHolder(
                url: data?.coverImgUrl,
                height: 110,
                width: 110,
              ),
            ),
            tag: "albumCover$id",
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  data == null ? "---" : data.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text("By:",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        fontSize: 14,
                      )),
                  SizedBox(width: 14),
                  ClipOval(
                    child: ImgPlaceHolder(
                      url: data?.creator?.avatarUrl,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  SizedBox(width: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 150),
                    child: Text(
                      data?.creator?.nickname ?? "---",
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  data == null
                      ? "---"
                      : (data.description == null
                          ? ""
                          : data.description),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
