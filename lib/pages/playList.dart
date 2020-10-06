import 'dart:convert';
import 'dart:math';

import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/components/loading.dart';
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

class PlaylistView extends StatefulWidget {
  PlaylistView({Key key, int limit}) : super(key: key);

  final int limit = 999;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  PlaylistContentData _playlistContentData;
  List<Widget> get songs {
    if (!haveData) {
      if (curId != null)
        Requests.getPlaylistContentData(curId).then((value) =>
            setState(() => _playlistContentData = value));
      return [
        for (int i = 0; i < 3; i++) MusicItem(),
      ];
    }
    return _playlistContentData.tracks
        .map((e) => MusicItem(
              song: e,
              curPlaylist: _playlistContentData.tracks,
            ))
        .toList()
        .sublist(
            0,
            min(_playlistContentData.tracks.length,
                widget.limit));
  }

  bool get haveData => _playlistContentData != null;

  String curId;

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
          children: [
            PlaylistProfile(
                id: args["id"], data: _playlistContentData),
            PartDevider(),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.play_arrow_outlined),
                onPressed: () {},
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
              onTap: () {},
            ),
            ...songs,
          ],
        ),
      ),
    );
  }
}

class PlaylistProfile extends StatelessWidget {
  const PlaylistProfile({Key key, this.id, this.data})
      : super(key: key);

  final int id;
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
