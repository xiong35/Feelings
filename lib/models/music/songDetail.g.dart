// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongDetail _$SongDetailFromJson(Map<String, dynamic> json) {
  return SongDetail()
    ..songs = (json['songs'] as List)
        ?.map(
            (e) => e == null ? null : Song.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num;
}

Map<String, dynamic> _$SongDetailToJson(SongDetail instance) =>
    <String, dynamic>{'songs': instance.songs, 'code': instance.code};
