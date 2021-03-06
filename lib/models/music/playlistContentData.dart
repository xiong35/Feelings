import 'package:json_annotation/json_annotation.dart';
import '../user/profile.dart';
// import "profile.dart";
import "song.dart";
import "songId.dart";
part 'playlistContentData.g.dart';

@JsonSerializable()
class PlaylistContentData {
  PlaylistContentData();

  Profile creator;
  List<Song> tracks;
  List<SongId> trackIds;
  String coverImgUrl;
  String description;
  String name;
  num id;

  factory PlaylistContentData.fromJson(
          Map<String, dynamic> json) =>
      _$PlaylistContentDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$PlaylistContentDataToJson(this);
}
