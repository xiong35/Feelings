import 'package:json_annotation/json_annotation.dart';
import '../music/playlistInfo.dart';
// import "playlistInfo.dart";
part 'recommendedPlaylist.g.dart';

@JsonSerializable()
class RecommendedPlaylist {
  RecommendedPlaylist();

  num code;
  List<PlaylistInfo> recommend;

  factory RecommendedPlaylist.fromJson(
          Map<String, dynamic> json) =>
      _$RecommendedPlaylistFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RecommendedPlaylistToJson(this);
}
