// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..user = json['user'] == null
        ? null
        : Profile.fromJson(json['user'] as Map<String, dynamic>)
    ..commentId = json['commentId'] as num
    ..content = json['content'] as String
    ..time = json['time'] as num
    ..likedCount = json['likedCount'] as num;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'user': instance.user,
      'commentId': instance.commentId,
      'content': instance.content,
      'time': instance.time,
      'likedCount': instance.likedCount
    };
