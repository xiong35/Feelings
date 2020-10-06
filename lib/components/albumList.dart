import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:flutter/material.dart';

import 'package:feelings/pages/playList.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({Key key, this.albums}) : super(key: key);

  final List<Widget> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      childAspectRatio: 1,
      children: albums,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

class AlbumItem extends StatelessWidget {
  final String coverUrl;
  final String name;
  final num id;

  AlbumItem({this.coverUrl, this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(4)),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          subtitle: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      child: GestureDetector(
        child: Hero(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImgPlaceHolder(
              url: coverUrl,
            ),
          ),
          tag: "albumCover$id",
        ),
        onTap: () => Navigator.pushNamed(
          context,
          "playlist",
          arguments: {'id': id},
        ),
      ),
    );
  }
}
