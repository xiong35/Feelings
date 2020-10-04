// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song()
    ..name = json['name'] as String
    ..id = json['id'] as num
    ..ar = (json['ar'] as List)
        ?.map((e) =>
            e == null ? null : ArtistBrief.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..al = json['al'] == null
        ? null
        : Album.fromJson(json['al'] as Map<String, dynamic>)
    ..mv = json['mv'] as num;
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'al': instance.al,
      'mv': instance.mv
    };
