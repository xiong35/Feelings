import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:feelings/global/http.dart';
import 'package:feelings/models/index.dart';
import 'package:feelings/models/music/songDetail.dart';
import 'package:feelings/models/user/likes.dart';

class Requests {
  static Future<PlaylistContentData> getPlaylistContentData(
      String id) async {
    String res =
        await GET("/playlist/detail", query: {"id": "$id"});

    return PlaylistContent.fromJson(
      json.decode(res),
    ).playlist;
  }

  static Future<List<Banner>> getBanners() async {
    String res = await GET("/banner");

    return Banners.fromJson(
      json.decode(res),
    ).banners;
  }

  static Future<List<Song>> getRecommendedSongs(
      [String cookie]) async {
    String res;
    if (cookie == null) {
      res =
          await GET("/artist/top/song", query: {"id": "96266"});

      return HotSongs.fromJson(
        json.decode(res),
      ).songs;
    } else {
      res = await GET("/recommend/songs",
          query: {"cookie": cookie});

      return RecommendSongs.fromJson(
        json.decode(res),
      ).data.dailySongs;
    }
  }

  static Future<List<PlaylistInfo>> getRecommendedPlaylists(
      [String cookie]) async {
    String res;
    List<PlaylistInfo> ret;
    if (cookie == null) {
      res = await GET("/top/playlist/highquality");

      ret = HotPlaylist.fromJson(
        json.decode(res),
      ).playlists;
    } else {
      res = await GET("/recommend/resource",
          query: {"cookie": cookie});

      ret = RecommendedPlaylist.fromJson(
        json.decode(res),
      ).recommend;
    }

    return ret.map((e) {
      var des = e.copywriter;
      if (des != null) e.description = des;
      return e;
    }).toList();
  }

  static Future<Profile> getUserProfile(String id) async {
    String res =
        await GET("/user/detail", query: {"uid": "$id"});

    return User.fromJson(
      json.decode(res),
    ).profile;
  }

  static Future<List<PlaylistInfo>> getUserPlaylists(
      String id) async {
    String res =
        await GET("/user/playlist", query: {"uid": "$id"});

    return UserPlaylists.fromJson(
      json.decode(res),
    ).playlist;
  }

  static Future<UserLvData> getUserLv(String cookie) async {
    String res =
        await GET("/user/level", query: {"cookie": "$cookie"});

    return UserLv.fromJson(
      json.decode(res),
    ).data;
  }

  static Future<String> getSongUrl(String id) async {
    String res = await GET("/song/url", query: {"id": "$id"});

    return SongUrls.fromJson(
      json.decode(res),
    ).data[0].url;
  }

  static Future<String> getSongLyric(String id) async {
    String res = await GET("/lyric", query: {"id": "$id"});

    return Lyric.fromJson(
      json.decode(res),
    )?.lrc?.lyric;
  }

  static Future<List<num>> getLikes(String cookie) async {
    String res =
        await GET("/likelist", query: {"cookie": cookie});

    return Likes.fromJson(
      json.decode(res),
    ).ids;
  }

  static Future setLike(
      String id, bool doLike, String cookie) async {
    await GET("/like",
        query: {"id": id, "like": "$doLike", "cookie": cookie});
  }

  static Future<List<String>> getHotTags() async {
    String res = await GET("/search/hot");

    return HotRes.fromJson(
      json.decode(res),
    )?.result?.hots?.map((e) => e.first)?.toList();
  }

  static Future<List<Song>> getSongDetail(
      List<String> ids) async {
    String res = await GET("/song/detail",
        query: {"ids": "${ids.join(',')}"});

    var resDecode = SongDetail.fromJson(
      json.decode(res),
    );
    if (resDecode?.songs == null ||
        resDecode.songs.length == 0) {
      return [];
    }
    return resDecode.songs;
  }

  static Future<Login> loginWithPhoneNPw(
      String phone, String pw) async {
    String md5Pw = md5.convert(utf8.encode(pw)).toString();
    String res = await GET(
      "/login/cellphone",
      query: {
        "md5_password": md5Pw,
        "phone": phone,
      },
    );

    return Login.fromJson(
      json.decode(res),
    );
  }
}
