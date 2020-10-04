// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songUrlData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongUrlData _$SongUrlDataFromJson(Map<String, dynamic> json) {
  return SongUrlData()
    ..id = json['id'] as num
    ..url = json['url'] as String
    ..code = json['code'] as num
    ..type = json['type'] as String
    ..encodeType = json['encodeType'] as String;
}

Map<String, dynamic> _$SongUrlDataToJson(SongUrlData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'code': instance.code,
      'type': instance.type,
      'encodeType': instance.encodeType
    };
