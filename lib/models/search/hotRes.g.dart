// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotRes _$HotResFromJson(Map<String, dynamic> json) {
  return HotRes()
    ..code = json['code'] as num
    ..result = json['result'] == null
        ? null
        : HotResult.fromJson(json['result'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HotResToJson(HotRes instance) =>
    <String, dynamic>{'code': instance.code, 'result': instance.result};
