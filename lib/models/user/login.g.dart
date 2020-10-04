// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login()
    ..token = json['token'] as String
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoginToJson(Login instance) =>
    <String, dynamic>{'token': instance.token, 'profile': instance.profile};
