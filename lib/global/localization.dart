import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//Locale资源类
class FeelingsLocalization {
  FeelingsLocalization(this.isZh);
  bool isZh = false;

  static FeelingsLocalization of(BuildContext context) {
    return Localizations.of<FeelingsLocalization>(
        context, FeelingsLocalization);
  }

  String get title {
    return isZh ? "Feelings" : "Feelings";
  }

  String get tabNameMine {
    return isZh ? "我的" : "Mine";
  }

  String get tabNameDiscovery {
    return isZh ? "发现" : "Discovery";
  }

  String get tabNameSearch {
    return isZh ? "搜索" : "Search";
  }

  String get tabNameSettings {
    return isZh ? "设置" : "Settings";
  }

  String get homeRecommendedSongs {
    return isZh ? "猜你喜欢" : "Recommended Songs";
  }

  String get homeRecommendedPlaylists {
    return isZh ? "歌单推荐" : "Recommended Playlists";
  }

  String get settingsSetTheme {
    return isZh ? "选择主题" : "Choose Theme";
  }

  String get settingsSetLanguage {
    return isZh ? "选择语言" : "Choose Language";
  }

  String get settingsLanguageOpsZH {
    return isZh ? "中文" : "Zh";
  }

  String get settingsLanguageOpsEN {
    return isZh ? "英文" : "En";
  }

  String get settingsLanguageOpsAuto {
    return isZh ? "自动" : "Auto";
  }

  String get settingsThemeOpsDark {
    return isZh ? "深色" : "Dark";
  }

  String get settingsThemeOpsLight {
    return isZh ? "浅色" : "Light";
  }

  String get userProfileFollowing {
    return isZh ? "关注" : "Following";
  }

  String get userProfileFans {
    return isZh ? "粉丝" : "Fans";
  }

  String get userPlaylists {
    return isZh ? "创建的歌单" : "Playlists";
  }

  String get userPopupMenuNew {
    return isZh ? "创建新歌单" : " Create Playlists";
  }

  String get userPopupMenuManage {
    return isZh ? "管理歌单" : "Manage Playlists";
  }

  String get playlistTitle {
    return isZh ? "歌单" : "Playlist";
  }

  String get playlistPlayAll {
    return isZh ? "播放全部" : "Play All";
  }
}

class FeelingsLocalizationsDelegate
    extends LocalizationsDelegate<FeelingsLocalization> {
  const FeelingsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<FeelingsLocalization> load(Locale locale) {
    return SynchronousFuture<FeelingsLocalization>(
        FeelingsLocalization(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(FeelingsLocalizationsDelegate old) => false;
}
