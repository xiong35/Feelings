// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendSongsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendSongsData _$RecommendSongsDataFromJson(Map<String, dynamic> json) {
  return RecommendSongsData()
    ..dailySongs = (json['dailySongs'] as List)
        ?.map(
            (e) => e == null ? null : Song.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RecommendSongsDataToJson(RecommendSongsData instance) =>
    <String, dynamic>{'dailySongs': instance.dailySongs};
