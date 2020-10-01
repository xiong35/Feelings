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
    // TODO bgc is not correspond to the theme
    return BottomAppBar(
      child: ListTile(
        leading: ExcludeSemantics(
          child: CircleAvatar(child: musicCover),
        ),
        title: Text(musicName),
        subtitle: Text(authorName),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_outline),
          onPressed: () => {},
        ),
      ),
    );
  }
}
