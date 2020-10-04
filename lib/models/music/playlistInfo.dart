import 'package:json_annotation/json_annotation.dart';
import '../user/profile.dart';
// import "profile.dart";
part 'playlistInfo.g.dart';

@JsonSerializable()
class PlaylistInfo {
  PlaylistInfo();

  String name;
  num id;
  String coverImgUrl;
  String picUrl;
  String copywriter;
  Profile creator;
  String description;

  factory PlaylistInfo.fromJson(Map<String, dynamic> json) =>
      _$PlaylistInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistInfoToJson(this);
}
