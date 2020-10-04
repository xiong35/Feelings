// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..level = json['level'] as num
    ..userPoint = json['userPoint'] == null
        ? null
        : UserPoint.fromJson(json['userPoint'] as Map<String, dynamic>)
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'level': instance.level,
      'userPoint': instance.userPoint,
      'profile': instance.profile
    };
