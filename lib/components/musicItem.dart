import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/global/theMusicController.dart';
import 'package:feelings/models/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicItem extends StatelessWidget {
  @required
  final Song song;
  final List<num> curPlaylist;

  MusicItem({
    this.song,
    this.curPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      // key: Key(song.id.toString()),
      onTap: () {
        Provider.of<MusicPlayModel>(context, listen: false)
            .refreshById(song.id, curPlaylist);
        Navigator.pushNamed(context, "musicPlay",
            arguments: {'id': song.id});
      },
      tileColor: colorScheme.background,
      title: Text(song == null ? "---" : song.name),
      subtitle: Text(song == null ? "---" : song.ar[0].name),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ImgPlaceHolder(
          height: 50,
          width: 50,
          url: song?.al?.picUrl,
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
