// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotItem _$HotItemFromJson(Map<String, dynamic> json) {
  return HotItem()
    ..first = json['first'] as String
    ..second = json['second'] as num
    ..third = json['third'] as String
    ..iconType = json['iconType'] as num;
}

Map<String, dynamic> _$HotItemToJson(HotItem instance) => <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
      'third': instance.third,
      'iconType': instance.iconType
    };
