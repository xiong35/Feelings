import 'package:flutter/material.dart';

import 'package:feelings/components/carousel.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/albumList.dart';
import 'package:feelings/global/localization.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carouselCards = <Widget>[
      CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/7Xo_K_5uXjxKO2b17GXwWw==/109951165358579060.jpg',
        ),
      ),
      CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/0_Gm0K665dKQZHxXYlrRrg==/109951165358172822.jpg',
        ),
      ),
      CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/mQ4QjYasMgP--oAPm49zXA==/109951165358572951.jpg',
        ),
      ),
    ];

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

    final List<Widget> albums = [
      AlbumItem(
        id: 33,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/29.png',
        name: "an album",
      ),
      AlbumItem(
        id: 33,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/29.png',
        name: "an album",
      ),
      AlbumItem(
        id: 33,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/29.png',
        name: "an album",
      ),
      AlbumItem(
        id: 33,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/29.png',
        name: "an album",
      ),
    ];

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
          AlbumList(albums: albums),
          PartDevider(height: 8),
        ],
      ),
    );
  }
}
