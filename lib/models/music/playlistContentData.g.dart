// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistContentData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistContentData _$PlaylistContentDataFromJson(Map<String, dynamic> json) {
  return PlaylistContentData()
    ..creator = json['creator'] == null
        ? null
        : Profile.fromJson(json['creator'] as Map<String, dynamic>)
    ..tracks = (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Song.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..coverImgUrl = json['coverImgUrl'] as String
    ..description = json['description'] as String
    ..name = json['name'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$PlaylistContentDataToJson(
        PlaylistContentData instance) =>
    <String, dynamic>{
      'creator': instance.creator,
      'tracks': instance.tracks,
      'coverImgUrl': instance.coverImgUrl,
      'description': instance.description,
      'name': instance.name,
      'id': instance.id
    };
