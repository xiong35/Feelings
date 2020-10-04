// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner()
    ..imageUrl = json['imageUrl'] as String
    ..targetId = json['targetId'] as num
    ..targetType = json['targetType'] as num
    ..typeTitle = json['typeTitle'] as String;
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'targetId': instance.targetId,
      'targetType': instance.targetType,
      'typeTitle': instance.typeTitle
    };
