// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userPlaylists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlaylists _$UserPlaylistsFromJson(Map<String, dynamic> json) {
  return UserPlaylists()
    ..version = json['version'] as String
    ..more = json['more'] as bool
    ..playlist = (json['playlist'] as List)
        ?.map((e) =>
            e == null ? null : PlaylistInfo.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num;
}

Map<String, dynamic> _$UserPlaylistsToJson(UserPlaylists instance) =>
    <String, dynamic>{
      'version': instance.version,
      'more': instance.more,
      'playlist': instance.playlist,
      'code': instance.code
    };
