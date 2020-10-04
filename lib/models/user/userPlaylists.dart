import 'package:json_annotation/json_annotation.dart';
import '../music/playlistInfo.dart';
// import "playlistInfo.dart";
part 'userPlaylists.g.dart';

@JsonSerializable()
class UserPlaylists {
  UserPlaylists();

  String version;
  bool more;
  List<PlaylistInfo> playlist;
  num code;

  factory UserPlaylists.fromJson(Map<String, dynamic> json) =>
      _$UserPlaylistsFromJson(json);
  Map<String, dynamic> toJson() => _$UserPlaylistsToJson(this);
}
