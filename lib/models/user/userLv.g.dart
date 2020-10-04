// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLv _$UserLvFromJson(Map<String, dynamic> json) {
  return UserLv()
    ..full = json['full'] as bool
    ..data = json['data'] == null
        ? null
        : UserLvData.fromJson(json['data'] as Map<String, dynamic>)
    ..code = json['code'] as num;
}

Map<String, dynamic> _$UserLvToJson(UserLv instance) => <String, dynamic>{
      'full': instance.full,
      'data': instance.data,
      'code': instance.code
    };
