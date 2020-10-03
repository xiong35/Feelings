import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/thePlayPanel.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/musicItem.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;

    final List<MusicItem> songs = <MusicItem>[
      MusicItem(
          name: 'song name',
          artist: 'artist',
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/28.png'),
      MusicItem(
          name: 'song name',
          artist: 'artist',
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/28.png'),
      MusicItem(
          name: 'song name',
          artist: 'artist',
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/28.png'),
    ];

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
          PlaylistProfile(id: args["id"]),
          PartDevider(),
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.play_arrow_outlined),
              onPressed: () {},
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
  const PlaylistProfile({Key key, this.id}) : super(key: key);

  final int id;

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
                "http://static.xiong35.cn/image/icons/open-doodles/3.png",
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
                "Playlist Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      "http://static.xiong35.cn/image/icons/open-doodles/2.png",
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text("User Name",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 14),
              Text(
                "this is ac fucking playlist. of $id",
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
