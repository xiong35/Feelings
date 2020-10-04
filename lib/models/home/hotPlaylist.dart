import 'package:json_annotation/json_annotation.dart';
import '../music/playlistInfo.dart';
// import "playlistInfo.dart";
part 'hotPlaylist.g.dart';

@JsonSerializable()
class HotPlaylist {
  HotPlaylist();

  List<PlaylistInfo> playlists;
  num code;

  factory HotPlaylist.fromJson(Map<String, dynamic> json) =>
      _$HotPlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$HotPlaylistToJson(this);
}
