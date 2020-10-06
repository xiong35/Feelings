import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/global/localization.dart';
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

    List likes =
        Provider.of<UserModel>(context, listen: true).likes;
    IconData display;
    if (likes == null)
      display = Icons.favorite_outline;
    else
      display = likes.contains(song?.id ?? -1)
          ? Icons.favorite
          : Icons.favorite_outline;

    return ListTile(
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
          display,
          color: colorScheme.primary,
        ),
        onPressed: () {
          var res =
              Provider.of<UserModel>(context, listen: false)
                  .toggleLikes(song?.id ?? -1);
          if (res != 0) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  res == 1
                      ? FeelingsLocalization.of(context).addLike
                      : FeelingsLocalization.of(context)
                          .removeLike,
                  textAlign: TextAlign.center,
                ),
                width: 200,
                backgroundColor:
                    Theme.of(context).colorScheme.secondary,
                elevation: 3,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  FeelingsLocalization.of(context)
                      .loginNeedLogin,
                ),
                width: 200,
                backgroundColor:
                    Theme.of(context).colorScheme.secondary,
                elevation: 3,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  textColor:
                      Theme.of(context).colorScheme.onPrimary,
                  label: "> " +
                      FeelingsLocalization.of(context)
                          .loginLogin +
                      " <",
                  onPressed: () => Navigator.pushNamed(
                    context,
                    "login",
                    arguments: {"showHint": true},
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
