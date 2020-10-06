import 'dart:convert';

import 'package:feelings/components/ImgPlaceHolder.dart';
import 'package:feelings/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/requests.dart';
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
          name: "please wait ...",
        ),
        AlbumItem(
          id: 67,
          name: "please wait ...",
        ),
        AlbumItem(
          id: 68,
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
        ..followeds = 0;
    }
    return _userProfile;
  }

  UserLvData _userLv;

  @override
  void initState() {
    super.initState();
    if (Global.loginData?.cookie == null) return;

    Requests.getUserPlaylists(
            "${Global.loginData.profile.userId}")
        .then((value) => setState(() => _playlists = value));
    Requests.getUserProfile(
            "${Global.loginData.profile.userId}")
        .then((value) => setState(() => _userProfile = value));
    Requests.getUserLv(Global.loginData.cookie)
        .then((value) => setState(() => _userLv = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(
        isLoading: _userLv == null,
        child: ListView(
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
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key key, this.userProfile, this.lv})
      : super(key: key);

  final Profile userProfile;
  final num lv;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 16, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            child: ImgPlaceHolder(
              url: userProfile.avatarUrl,
              height: 100,
              width: 100,
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
