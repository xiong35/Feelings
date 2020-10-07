// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult()
    ..queryCorrected = json['queryCorrected'] as List
    ..songs = (json['songs'] as List)
        ?.map((e) => e == null
            ? null
            : Song.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..hasMore = json['hasMore'] as bool
    ..songCount = json['songCount'] as num;
}

Map<String, dynamic> _$SearchResultToJson(
        SearchResult instance) =>
    <String, dynamic>{
      'queryCorrected': instance.queryCorrected,
      'songs': instance.songs,
      'hasMore': instance.hasMore,
      'songCount': instance.songCount
    };
