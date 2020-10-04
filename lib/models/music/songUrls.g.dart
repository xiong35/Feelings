// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songUrls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongUrls _$SongUrlsFromJson(Map<String, dynamic> json) {
  return SongUrls()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SongUrlData.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num;
}

Map<String, dynamic> _$SongUrlsToJson(SongUrls instance) =>
    <String, dynamic>{'data': instance.data, 'code': instance.code};
