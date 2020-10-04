// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotSongs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSongs _$HotSongsFromJson(Map<String, dynamic> json) {
  return HotSongs()
    ..code = json['code'] as num
    ..songs = (json['songs'] as List)
        ?.map(
            (e) => e == null ? null : Song.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HotSongsToJson(HotSongs instance) =>
    <String, dynamic>{'code': instance.code, 'songs': instance.songs};
