// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistContent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistContent _$PlaylistContentFromJson(Map<String, dynamic> json) {
  return PlaylistContent()
    ..code = json['code'] as num
    ..playlist = json['playlist'] == null
        ? null
        : PlaylistContentData.fromJson(
            json['playlist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlaylistContentToJson(PlaylistContent instance) =>
    <String, dynamic>{'code': instance.code, 'playlist': instance.playlist};
