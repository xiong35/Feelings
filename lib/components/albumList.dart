import 'package:flutter/material.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({Key key, this.albums}) : super(key: key);

  final List<Widget> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 18,
      crossAxisSpacing: 18,
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
  final int id;

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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: () {},
              color: Theme.of(context).colorScheme.onPrimary,
            )),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          coverUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
