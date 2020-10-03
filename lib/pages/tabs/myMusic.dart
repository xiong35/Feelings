import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/outlinedChip.dart';
import 'package:feelings/components/albumList.dart';

class MineView extends StatelessWidget {
  const MineView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> albums = [
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/29.png',
        name:
            "My album lalala lalala lalala la la la la la la la",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/25.png',
        name: "My album",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/23.png',
        name: "My album",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/17.png',
        name: "My album",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/11.png',
        name: "My album",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/13.png',
        name: "My album",
      ),
      AlbumItem(
        id: 66,
        coverUrl:
            'http://static.xiong35.cn/image/icons/open-doodles/1.png',
        name: "My album",
      ),
    ];

    return Scaffold(
      body: ListView(
        children: [
          UserProfile(),
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
          AlbumList(albums: albums),
          PartDevider(),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            child: Image.network(
              "http://static.xiong35.cn/image/icons/open-doodles/2.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(FeelingsLocalization.of(context)
                      .userProfileFollowing),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      width: 1,
                      height: 12,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: colorScheme.primaryVariant),
                      ),
                    ),
                  ),
                  Text(FeelingsLocalization.of(context)
                      .userProfileFans),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                children: [
                  OutlinedChip(
                      color: colorScheme.primary, text: "Lv 9"),
                  SizedBox(width: 12),
                  OutlinedChip(
                      color: colorScheme.secondary,
                      text: "VIP"),
                ],
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
