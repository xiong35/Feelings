import 'package:flutter/material.dart';

import 'package:feelings/components/carousel.dart';
import 'package:feelings/components/musicItem.dart';
import 'package:feelings/components/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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

    return Scaffold(
      body: ListView(
        children: [
          Carousel(
            children: carouselCards,
          ),
          PartDevider(height: 8),
          HeadingWithIcon(
            heading: "猜你喜欢",
            iconData: Icons.refresh,
            onPressed: () {},
          ),
          ...songs,
          PartDevider(height: 8),
          HeadingWithIcon(
            heading: "歌单推荐",
            iconData: Icons.refresh,
            onPressed: () {},
          ),
          ...songs,
        ],
      ),
    );
  }
}
