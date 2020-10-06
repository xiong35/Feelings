import 'dart:convert';
import 'dart:math';

import 'package:feelings/global/global.dart';
import 'package:flutter/material.dart' hide Banner;

import 'package:feelings/components/loading.dart';
import 'package:feelings/components/carousel.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/albumList.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/requests.dart';
import 'package:feelings/models/index.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  List<Banner> _banners;
  List<Widget> get carouselCards {
    Requests.getBanners()
        .then((value) => setState(() => _banners = value));
    if (_banners == null) {
      return [
        CarouselCard(
          text: "",
        ),
        CarouselCard(
          text: "",
        )
      ];
    }
    return _banners
        .map(
          (e) => CarouselCard(
            url: e.imageUrl,
            text: e.typeTitle,
          ),
        )
        .toList();
  }

  List<Song> _songs;
  List<Widget> get songs {
    if (_songs == null) {
      Requests.getRecommendedSongs(Global?.loginData?.cookie)
          .then((value) => setState(() => _songs = value));
      return [
        for (var i = 0; i < 3; i++) MusicItem(),
      ];
    }
    return _songs
        .map((e) => MusicItem(song: e, curPlaylist: _songs))
        .toList()
        .sublist(0, min(_songs.length, 5));
  }

  List<PlaylistInfo> _playlists;
  List<Widget> get playlists {
    if (_playlists == null) {
      Requests.getRecommendedPlaylists(
              Global?.loginData?.cookie)
          .then((value) => setState(() => _playlists = value));
      return [
        AlbumItem(
          id: 30,
          name: "an album",
        ),
        AlbumItem(
          id: 31,
          name: "an album",
        ),
        AlbumItem(
          id: 31,
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Loading(
        isLoading: _banners == null,
        child: ListView(
          children: [
            Carousel(
              children: carouselCards,
            ),
            PartDevider(height: 8),
            ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color:
                      Theme.of(context).colorScheme.secondary,
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
                  color:
                      Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
