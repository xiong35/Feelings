// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistInfo _$PlaylistInfoFromJson(Map<String, dynamic> json) {
  return PlaylistInfo()
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..coverImgUrl = json['coverImgUrl'] as String
    ..picUrl = json['picUrl'] as String
    ..copywriter = json['copywriter'] as String
    ..creator = json['creator'] == null
        ? null
        : Profile.fromJson(json['creator'] as Map<String, dynamic>)
    ..description = json['description'] as String;
}

Map<String, dynamic> _$PlaylistInfoToJson(PlaylistInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'coverImgUrl': instance.coverImgUrl,
      'picUrl': instance.picUrl,
      'copywriter': instance.copywriter,
      'creator': instance.creator,
      'description': instance.description
    };
