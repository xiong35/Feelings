import 'package:flutter/material.dart';

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
        leading: ExcludeSemantics(
          child: ClipOval(
            child: musicCover,
          ),
        ),
        title: Text(musicName),
        subtitle: Text(authorName),
        trailing: IconButton(
          icon: Icon(
            Icons.play_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => {},
          iconSize: 32.0,
        ),
      ),
    );
  }
}
