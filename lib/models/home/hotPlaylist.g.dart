// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotPlaylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotPlaylist _$HotPlaylistFromJson(Map<String, dynamic> json) {
  return HotPlaylist()
    ..playlists = (json['playlists'] as List)
        ?.map((e) =>
            e == null ? null : PlaylistInfo.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num;
}

Map<String, dynamic> _$HotPlaylistToJson(HotPlaylist instance) =>
    <String, dynamic>{'playlists': instance.playlists, 'code': instance.code};
