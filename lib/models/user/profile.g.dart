// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..avatarImgIdStr = json['avatarImgIdStr'] as String
    ..avatarImgId = json['avatarImgId'] as num
    ..gender = json['gender'] as num
    ..nickname = json['nickname'] as String
    ..vipType = json['vipType'] as num
    ..avatarUrl = json['avatarUrl'] as String
    ..signature = json['signature'] as String
    ..followeds = json['followeds'] as num
    ..userId = json['userId'] as num
    ..follows = json['follows'] as num;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) =>
    <String, dynamic>{
      'avatarImgIdStr': instance.avatarImgIdStr,
      'avatarImgId': instance.avatarImgId,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'vipType': instance.vipType,
      'userId': instance.userId,
      'avatarUrl': instance.avatarUrl,
      'signature': instance.signature,
      'followeds': instance.followeds,
      'follows': instance.follows
    };
