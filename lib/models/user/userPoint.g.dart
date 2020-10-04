// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userPoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPoint _$UserPointFromJson(Map<String, dynamic> json) {
  return UserPoint()
    ..userId = json['userId'] as num
    ..balance = json['balance'] as num
    ..updateTime = json['updateTime'] as num
    ..version = json['version'] as num
    ..status = json['status'] as num;
}

Map<String, dynamic> _$UserPointToJson(UserPoint instance) => <String, dynamic>{
      'userId': instance.userId,
      'balance': instance.balance,
      'updateTime': instance.updateTime,
      'version': instance.version,
      'status': instance.status
    };
