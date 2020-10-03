import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/utils.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: ListView(
        children: [
          PlaylistProfile(id: args['id']),
          PartDevider(),
          ListTile(
            title: Text(
              FeelingsLocalization.of(context).userPlaylists,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: PlayistPopupBtn(),
          ),
        ],
      ),
    );
  }
}

class PlaylistProfile extends StatelessWidget {
  const PlaylistProfile({Key key, this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.network(
              "http://static.xiong35.cn/image/icons/open-doodles/2.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Playlist Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      "http://static.xiong35.cn/image/icons/open-doodles/2.png",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text("User Name"),
                ],
              ),
              SizedBox(height: 14),
              Text(
                "this is ac fucking playlist. of $id",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PlayistPopupBtn extends StatelessWidget {
  const PlayistPopupBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => <PopupMenuItem>[
        PopupMenuItem(
          value: "new",
          child: ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text(FeelingsLocalization.of(context)
                .userPopupMenuNew),
          ),
        ),
        PopupMenuItem(
          value: "manage",
          child: ListTile(
            leading: Icon(Icons.format_list_bulleted),
            title: Text(FeelingsLocalization.of(context)
                .userPopupMenuManage),
          ),
        ),
      ],
      onSelected: (value) => print(value),
    );
  }
}
