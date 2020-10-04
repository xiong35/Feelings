import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:feelings/components/carousel.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/albumList.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/http.dart';
import 'package:feelings/models/index.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Banners _banners;
  List<Widget> get carouselCards {
    if (_banners == null) {
      return [
        CarouselCard(
          asset: const NetworkImage(
            'http://p1.music.126.net/mQ4QjYasMgP--oAPm49zXA==/109951165358572951.jpg',
          ),
          text: "",
        ),
        CarouselCard(
          asset: const NetworkImage(
            'http://p1.music.126.net/mQ4QjYasMgP--oAPm49zXA==/109951165358572951.jpg',
          ),
          text: "",
        )
      ];
    }
    return _banners.banners
        .map(
          (e) => CarouselCard(
            asset: NetworkImage(e.imageUrl),
            text: e.typeTitle,
          ),
        )
        .toList();
  }

  List<Song> _songs;
  List<Widget> get songs {
    if (_songs == null) {
      return [
        for (var i = 0; i < 3; i++)
          MusicItem(
              name: 'song name',
              artist: 'artist',
              coverUrl:
                  'http://static.xiong35.cn/image/icons/open-doodles/$i.png'),
      ];
    }
    return _songs
        .map(
          (e) => MusicItem(
            name: e.name,
            artist: e.ar[0].name,
            coverUrl: e.al.picUrl,
            id: e.id,
          ),
        )
        .toList()
        .sublist(0, min(_songs.length, 5));
  }

  List<PlaylistInfo> _playlists;
  List<Widget> get playlists {
    if (_playlists == null) {
      return [
        AlbumItem(
          id: 30,
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/29.png',
          name: "an album",
        ),
        AlbumItem(
          id: 31,
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/29.png',
          name: "an album",
        )
      ];
    }
    return _playlists
        .map((e) => AlbumItem(
              id: e.id,
              coverUrl: e.coverImgUrl == null
                  ? e.picUrl
                  : e.coverImgUrl,
              name: e.name,
            ))
        .toList();
  }

  @override
  void initState() {
    GET("/banner").then(
      (v) => setState(() => _banners = Banners.fromJson(
            json.decode(v),
          )),
    );
    GET("/artist/top/song", query: {"id": "6452"}).then(
      (v) => setState(() => _songs = HotSongs.fromJson(
            json.decode(v),
          ).songs),
    );
    GET("/top/playlist/highquality").then(
      (v) => setState(() => _playlists = HotPlaylist.fromJson(
            json.decode(v),
          ).playlists),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Carousel(
            children: carouselCards,
          ),
          PartDevider(height: 8),
          ListTile(
            trailing: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.secondary,
                size: 28,
              ),
              onPressed: () {},
            ),
            title: Text(
              FeelingsLocalization.of(context)
                  .homeRecommendedSongs,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          ...songs,
          PartDevider(height: 8),
          ListTile(
            trailing: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.secondary,
                size: 28,
              ),
              onPressed: () {},
            ),
            title: Text(
              FeelingsLocalization.of(context)
                  .homeRecommendedPlaylists,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          AlbumList(albums: playlists),
          PartDevider(height: 8),
        ],
      ),
    );
  }
}
