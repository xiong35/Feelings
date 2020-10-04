// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..picUrl = json['picUrl'] as String
    ..tns = (json['tns'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'tns': instance.tns
    };
