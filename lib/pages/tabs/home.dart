import 'dart:convert';
import 'dart:math';

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

class _HomeViewState extends State<HomeView> {
  List<Banner> _banners;
  List<Widget> get carouselCards {
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
      return [
        AlbumItem(
          id: 30,
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
  void initState() {
    Requests.getBanners()
        .then((value) => setState(() => _banners = value));
    Requests.getRecommendedSongs()
        .then((value) => setState(() => _songs = value));
    Requests.getRecommendedPlaylists()
        .then((value) => setState(() => _playlists = value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
