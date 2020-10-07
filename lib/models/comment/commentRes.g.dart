// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRes _$CommentResFromJson(Map<String, dynamic> json) {
  return CommentRes()
    ..hotComments = (json['hotComments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..code = json['code'] as num
    ..total = json['total'] as num;
}

Map<String, dynamic> _$CommentResToJson(CommentRes instance) =>
    <String, dynamic>{
      'hotComments': instance.hotComments,
      'code': instance.code,
      'total': instance.total
    };
