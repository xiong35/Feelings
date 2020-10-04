// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendedPlaylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedPlaylist _$RecommendedPlaylistFromJson(Map<String, dynamic> json) {
  return RecommendedPlaylist()
    ..code = json['code'] as num
    ..recommend = (json['recommend'] as List)
        ?.map((e) =>
            e == null ? null : PlaylistInfo.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RecommendedPlaylistToJson(
        RecommendedPlaylist instance) =>
    <String, dynamic>{'code': instance.code, 'recommend': instance.recommend};
