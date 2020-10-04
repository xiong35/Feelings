// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyric _$LyricFromJson(Map<String, dynamic> json) {
  return Lyric()
    ..lrc = json['lrc'] == null
        ? null
        : LyricData.fromJson(json['lrc'] as Map<String, dynamic>)
    ..code = json['code'] as num;
}

Map<String, dynamic> _$LyricToJson(Lyric instance) =>
    <String, dynamic>{'lrc': instance.lrc, 'code': instance.code};
