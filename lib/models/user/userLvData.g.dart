// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLvData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLvData _$UserLvDataFromJson(Map<String, dynamic> json) {
  return UserLvData()
    ..userId = json['userId'] as num
    ..info = json['info'] as String
    ..progress = json['progress'] as num
    ..nextPlayCount = json['nextPlayCount'] as num
    ..nextLoginCount = json['nextLoginCount'] as num
    ..nowPlayCount = json['nowPlayCount'] as num
    ..nowLoginCount = json['nowLoginCount'] as num
    ..level = json['level'] as num;
}

Map<String, dynamic> _$UserLvDataToJson(UserLvData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'info': instance.info,
      'progress': instance.progress,
      'nextPlayCount': instance.nextPlayCount,
      'nextLoginCount': instance.nextLoginCount,
      'nowPlayCount': instance.nowPlayCount,
      'nowLoginCount': instance.nowLoginCount,
      'level': instance.level
    };
