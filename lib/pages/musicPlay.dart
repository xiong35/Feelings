import 'package:feelings/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/global/theMusicController.dart';

const iconDataList = [
  Icons.repeat,
  Icons.repeat_one,
  Icons.shuffle
];

class MusicPlayView extends StatefulWidget {
  MusicPlayView({Key key}) : super(key: key);

  @override
  _MusicPlayViewState createState() => _MusicPlayViewState();
}

class _MusicPlayViewState extends State<MusicPlayView> {
  bool isLoading = false;
  void setLoading(bool state) {
    setState(() => isLoading = state);
  }

  @override
  Widget build(BuildContext context) {
    MusicPlayModel musicPlayModelListen =
        Provider.of<MusicPlayModel>(context, listen: true);

    return Loading(
      isLoading: isLoading,
      child: Scaffold(
        bottomNavigationBar: _PlayPanel(setLoading: setLoading),
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.background,
          title: Text(
            musicPlayModelListen.curSong.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          elevation: 1,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                child: Hero(
                  tag:
                      "musicCover${musicPlayModelListen.curSong.al.id}",
                  child: ClipRRect(
                    child: Image.network(
                      musicPlayModelListen.curSong.al.picUrl,
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
                musicPlayModelListen.curSong.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 6),
              Text(musicPlayModelListen.curSong.ar[0].name),
              SizedBox(height: 12),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       for (int i = 0; i < 100; i++) Text("test"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayPanel extends StatelessWidget {
  const _PlayPanel({
    Key key,
    this.setLoading,
  }) : super(key: key);

  final Function setLoading;

  void onPressedWrapper(Function fn) async {
    setLoading(true);
    await fn();
    setLoading(false);
  }

  String togglePlayMode(BuildContext context) {
    var tipList = [
      FeelingsLocalization.of(context).playModeLoopAll,
      FeelingsLocalization.of(context).playModeLoopSingle,
      FeelingsLocalization.of(context).playModeShuffle,
    ];

    int newMode =
        Provider.of<MusicPlayModel>(context, listen: false)
            .togglePlayMode();

    return tipList[newMode];
  }

  @override
  Widget build(BuildContext context) {
    var musicPlayModelListen =
        Provider.of<MusicPlayModel>(context, listen: true);
    var musicPlayModel =
        Provider.of<MusicPlayModel>(context, listen: false);

    return IconTheme(
      child: SizedBox(
          height: 125,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                      musicPlayModelListen.curPosition
                          .toString()
                          .substring(2, 7),
                      style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Slider(
                      value: musicPlayModelListen.percent,
                      onChanged: (value) {
                        musicPlayModelListen.percent = value;
                      },
                      activeColor: Theme.of(context)
                          .colorScheme
                          .secondary,
                    ),
                  ),
                  Text(
                      musicPlayModelListen.curDuration
                          .toString()
                          .substring(2, 7),
                      style: TextStyle(fontSize: 14)),
                  SizedBox(width: 10),
                ],
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
                        iconDataList[
                            musicPlayModelListen.playMode],
                        size: 30,
                      ),
                      onPressed: () {
                        int newMode =
                            musicPlayModel.togglePlayMode();
                        var tipList = [
                          FeelingsLocalization.of(context)
                              .playModeLoopAll,
                          FeelingsLocalization.of(context)
                              .playModeLoopSingle,
                          FeelingsLocalization.of(context)
                              .playModeShuffle,
                        ];
                        Scaffold.of(context)
                            .hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              tipList[newMode],
                              textAlign: TextAlign.center,
                            ),
                            width: 120,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary,
                            elevation: 3,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
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
                      onPressed: () {
                        onPressedWrapper(() async {
                          await musicPlayModel
                              .cutSong(SongChangeType.backward);
                        });
                      },
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
                          onPressedWrapper(() async {
                        await musicPlayModel.togglePlay();
                      }),
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
                      onPressed: () {
                        onPressedWrapper(() async {
                          await musicPlayModel
                              .cutSong(SongChangeType.forward);
                        });
                      },
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
