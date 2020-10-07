// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotResult _$HotResultFromJson(Map<String, dynamic> json) {
  return HotResult()
    ..hots = (json['hots'] as List)
        ?.map((e) =>
            e == null ? null : HotItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HotResultToJson(HotResult instance) =>
    <String, dynamic>{'hots': instance.hots};
