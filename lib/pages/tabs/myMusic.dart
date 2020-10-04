import 'dart:convert';

import 'package:feelings/global/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/outlinedChip.dart';
import 'package:feelings/components/albumList.dart';
import 'package:feelings/models/index.dart';

class MineView extends StatefulWidget {
  MineView({Key key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  List<PlaylistInfo> _playlists;
  List<Widget> get playlists {
    if (_playlists == null) {
      return [
        AlbumItem(
          id: 66,
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/29.png',
          name: "please wait ...",
        ),
        AlbumItem(
          id: 67,
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/25.png',
          name: "please wait ...",
        ),
        AlbumItem(
          id: 68,
          coverUrl:
              'http://static.xiong35.cn/image/icons/open-doodles/23.png',
          name: "please wait ...",
        )
      ];
    }
    return _playlists
        .map((e) => AlbumItem(
              id: e.id,
              coverUrl: e.coverImgUrl == null
                  ? e.picUrl
                  : e.coverImgUrl,
              name: e.name,
            ))
        .toList();
  }

  Profile _userProfile;
  Profile get userProfile {
    if (_userProfile == null) {
      return Profile()
        ..nickname = "---"
        ..follows = 0
        ..followeds = 0
        ..avatarUrl =
            "http://static.xiong35.cn/image/icons/open-doodles/2.png";
    }
    return _userProfile;
  }

  UserLvData _userLv;

  @override
  void initState() {
    GET("/user/playlist", query: {"uid": "32953014"}).then(
      (value) => setState(
        () => _playlists = UserPlaylists.fromJson(
          json.decode(value),
        ).playlist,
      ),
    );
    GET("/user/detail", query: {"uid": "32953014"}).then(
      (value) => setState(
        () => _userProfile = User.fromJson(
          json.decode(value),
        ).profile,
      ),
    );
    GET("/user/level", query: {
      "cookie":
          "MUSIC_U=dfb63537bb362fdf9ba6d8198d50f82ea47502cfcd8f45744cc401092d75f8e833a649814e309366; Expires=Mon, 19-Oct-2020 11:14:35 GMT; Path=/;__remember_me=true; Expires=Mon, 19-Oct-2020 11:14:35 GMT; Path=/;__csrf=253e92d60137c270a17f14b346ad257a; Expires=Mon, 19-Oct-2020 11:14:45 GMT; Path=/"
    }).then(
      (value) => setState(
        () => _userLv = UserLv.fromJson(
          json.decode(value),
        ).data,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserProfile(
            userProfile: userProfile,
            lv: _userLv == null ? 1 : _userLv.level,
          ),
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
          AlbumList(albums: playlists),
          PartDevider(),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key key, this.userProfile, this.lv})
      : super(key: key);

  final Profile userProfile;
  final int lv;

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
              userProfile.avatarUrl,
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
                userProfile.nickname,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(FeelingsLocalization.of(context)
                          .userProfileFollowing +
                      ": ${userProfile.follows}"),
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
                          .userProfileFans +
                      ": ${userProfile.followeds}"),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                children: [
                  OutlinedChip(
                      color: colorScheme.primary,
                      text: "Lv $lv"),
                  SizedBox(width: 12),
                  if (userProfile.vipType == 11)
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
