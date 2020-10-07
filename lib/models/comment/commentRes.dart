import 'package:json_annotation/json_annotation.dart';
import "comment.dart";
part 'commentRes.g.dart';

@JsonSerializable()
class CommentRes {
    CommentRes();

    List<Comment> hotComments;
    num code;
    num total;
    
    factory CommentRes.fromJson(Map<String,dynamic> json) => _$CommentResFromJson(json);
    Map<String, dynamic> toJson() => _$CommentResToJson(this);
}
