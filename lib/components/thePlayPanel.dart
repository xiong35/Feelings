import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/global/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThePlayPanel extends StatelessWidget {
  const ThePlayPanel();

  @override
  Widget build(BuildContext context) {
    MusicPlayModel musicPlayModelListen =
        Provider.of<MusicPlayModel>(context, listen: true);

    return BottomAppBar(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, "musicPlay",
            arguments: {'id': 66}), //TODO: id
        leading: Hero(
          child: ClipOval(
            child: ImgPlaceHolder(
              url: musicPlayModelListen?.curSong?.al?.picUrl,
              height: 50.0,
              width: 50.0,
            ),
          ),
          tag:
              "musicCover${musicPlayModelListen.curSong.al.id}",
        ),
        title: Text(musicPlayModelListen.curSong.name),
        subtitle: Text(musicPlayModelListen.curSong.ar[0].name),
        trailing: IconButton(
          icon: Icon(
            Provider.of<MusicPlayModel>(context, listen: true)
                    .isPlaying
                ? Icons.pause_circle_outline
                : Icons.play_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Provider.of<MusicPlayModel>(context,
                  listen: false)
              .togglePlay(),
          iconSize: 32.0,
        ),
      ),
    );
  }
}
