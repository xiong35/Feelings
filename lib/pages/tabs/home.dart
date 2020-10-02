import 'dart:async';
import 'package:flutter/material.dart';

import 'package:feelings/components/carousel.dart';

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

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Carousel(
            children: carouselCards,
          ),
        ],
      ),
    );
  }
}
