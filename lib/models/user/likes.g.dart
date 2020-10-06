// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) {
  return Likes()
    ..ids = (json['ids'] as List)
        .map((e) => (e == null) ? null : e as num)
        .toList()
    ..checkPoint = json['checkPoint'] as num
    ..code = json['code'] as num;
}

Map<String, dynamic> _$LikesToJson(Likes instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'checkPoint': instance.checkPoint,
      'code': instance.code
    };
