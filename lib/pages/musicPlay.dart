import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';

class MusicPlayView extends StatefulWidget {
  MusicPlayView({Key key}) : super(key: key);

  @override
  _MusicPlayViewState createState() => _MusicPlayViewState();
}

class _MusicPlayViewState extends State<MusicPlayView> {
  AudioPlayer audioPlayer = AudioPlayer();

  play() async {
    int result = await audioPlayer.play(
        "https://luan.xyz/files/audio/nasa_on_a_mission.mp3");
    if (result == 1) {
      // success
      print('play success');
    } else {
      print('play failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _PlayPanel(playBtnClicked: play),
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
    this.playBtnClicked,
  }) : super(key: key);

  final double value;
  final Function playBtnClicked;

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
                        Icons.play_arrow_outlined,
                        size: 50,
                      ),
                      onPressed: playBtnClicked,
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
