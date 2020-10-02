import 'package:flutter/material.dart';

class MusicItem extends StatelessWidget {
  @required
  final String name;
  @required
  final String artist;
  @required
  final String coverUrl;
  final int id;

  MusicItem({
    this.name,
    this.artist,
    this.coverUrl,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      tileColor: colorScheme.background,
      title: Text(name),
      subtitle: Text(artist),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          coverUrl,
          fit: BoxFit.cover,
          height: 50.0,
          width: 50.0,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.favorite_outline,
          color: colorScheme.primary,
        ),
        onPressed: null,
      ),
    );
  }
}
