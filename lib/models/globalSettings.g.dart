// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globalSettings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalSettings _$GlobalSettingsFromJson(
    Map<String, dynamic> json) {
  return GlobalSettings()
    ..locale = json['locale'] as String
    ..theme = json['theme'] as String
    ..curPlayMode = json['curPlayMode'] as num
    ..loginData = json['loginData']
    ..curSong = json['curSong']
    ..curPlaylist = json['curPlaylist'] as List;
}

Map<String, dynamic> _$GlobalSettingsToJson(
        GlobalSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'theme': instance.theme,
      'curPlayMode': instance.curPlayMode,
      'loginData': instance.loginData,
      'curSong': instance.curSong,
      'curPlaylist': instance.curPlaylist
    };
