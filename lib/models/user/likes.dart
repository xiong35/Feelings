import 'package:json_annotation/json_annotation.dart';

part 'likes.g.dart';

@JsonSerializable()
class Likes {
  Likes();

  List<num> ids;
  num checkPoint;
  num code;

  factory Likes.fromJson(Map<String, dynamic> json) =>
      _$LikesFromJson(json);
  Map<String, dynamic> toJson() => _$LikesToJson(this);
}
