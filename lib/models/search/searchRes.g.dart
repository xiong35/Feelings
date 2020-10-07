// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRes _$SearchResFromJson(Map<String, dynamic> json) {
  return SearchRes()
    ..result = json['result'] == null
        ? null
        : SearchResult.fromJson(json['result'] as Map<String, dynamic>)
    ..code = json['code'] as num;
}

Map<String, dynamic> _$SearchResToJson(SearchRes instance) =>
    <String, dynamic>{'result': instance.result, 'code': instance.code};
