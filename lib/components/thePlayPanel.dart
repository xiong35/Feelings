import 'package:feelings/global/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThePlayPanel extends StatelessWidget {
  const ThePlayPanel({
    this.musicCover,
    this.musicName,
    this.authorName,
  });

  final Image musicCover;
  final String musicName;
  final String authorName;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, "musicPlay",
            arguments: {'id': 66}), //TODO: id
        leading: Hero(
          child: ClipOval(
            child: musicCover,
          ),
          tag: "musicCover",
        ),
        title: Text(musicName),
        subtitle: Text(authorName),
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
