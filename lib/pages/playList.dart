import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/thePlayPanel.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/models/index.dart';
import 'package:feelings/global/http.dart';

class PlaylistView extends StatefulWidget {
  PlaylistView({Key key}) : super(key: key);

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  PlaylistContentData _playlistContentData;
  List<Widget> get songs {
    if (!haveData) {
      return [
        for (var i = 0; i < 3; i++)
          MusicItem(
              name: 'song name',
              artist: 'artist',
              coverUrl:
                  'http://static.xiong35.cn/image/icons/open-doodles/$i.png'),
      ];
    }
    return _playlistContentData.tracks
        .map(
          (e) => MusicItem(
            name: e.name,
            artist: e.ar[0].name,
            coverUrl: e.al.picUrl,
            id: e.id,
          ),
        )
        .toList()
        .sublist(0, min(_playlistContentData.tracks.length, 5));
  }

  bool get haveData => _playlistContentData != null;

  @override
  void initState() {
    GET("/playlist/detail", query: {"id": "24381616"}).then(
      (value) => setState(
        () => _playlistContentData = PlaylistContent.fromJson(
          json.decode(value),
        ).playlist,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      bottomNavigationBar: ThePlayPanel(
        authorName: "author",
        musicName: "Feelings",
        musicCover: Image.network(
          "http://static.xiong35.cn/image/icons/open-doodles/15.png",
          fit: BoxFit.cover,
          height: 50.0,
          width: 50.0,
        ),
      ),
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
      body: ListView(
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
              FeelingsLocalization.of(context).playlistPlayAll,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ...songs,
        ],
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
              child: Image.network(
                data == null
                    ? "http://static.xiong35.cn/image/icons/open-doodles/3.png"
                    : data.coverImgUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            tag: "albumCover$id",
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data == null ? "---" : data.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                    child: Image.network(
                      data == null
                          ? "http://static.xiong35.cn/image/icons/open-doodles/2.png"
                          : data.creator.avatarUrl,
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                      data == null
                          ? "---"
                          : data.creator.nickname,
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 14),
              Text(
                data == null ? "---" : data.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ],
      ),
    );
  }
}
