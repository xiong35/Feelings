// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendSongs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendSongs _$RecommendSongsFromJson(Map<String, dynamic> json) {
  return RecommendSongs()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : RecommendSongsData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RecommendSongsToJson(RecommendSongs instance) =>
    <String, dynamic>{'code': instance.code, 'data': instance.data};
