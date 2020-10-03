import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/global/theMusicController.dart';

class MusicPlayView extends StatefulWidget {
  MusicPlayView({Key key}) : super(key: key);

  @override
  _MusicPlayViewState createState() => _MusicPlayViewState();
}

class _MusicPlayViewState extends State<MusicPlayView> {
  bool isPlaying = theMusicController.isPlaying;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _PlayPanel(),
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.background,
        title: Text(
          "Song Name",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            child: Hero(
              tag: "musicCover",
              child: ClipRRect(
                child: Image.network(
                  "http://static.xiong35.cn/image/icons/open-doodles/15.png",
                  fit: BoxFit.cover,
                  height: 240.0,
                  width: 240.0,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 50, 0, 15),
          ),
          Text(
            "Song name",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 6),
          Text("Artist"),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPanel extends StatelessWidget {
  const _PlayPanel({
    Key key,
    this.value = 0.5,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      child: SizedBox(
          height: 125,
          child: Column(
            children: [
              Slider(
                value: value,
                onChanged: (_) {},
                activeColor:
                    Theme.of(context).colorScheme.secondary,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_previous_outlined,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Provider.of<MusicPlayModel>(context,
                                    listen: true)
                                .isPlaying
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        size: 50,
                      ),
                      onPressed: () =>
                          Provider.of<MusicPlayModel>(context,
                                  listen: false)
                              .togglePlay(),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_next_outlined,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.mode_comment_outlined,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          )),
      data: IconThemeData(
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
