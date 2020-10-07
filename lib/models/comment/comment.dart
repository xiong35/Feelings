import 'package:json_annotation/json_annotation.dart';
import '../user/profile.dart';
// import "profile.dart";
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment();

  Profile user;
  num commentId;
  String content;
  num time;
  num likedCount;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
