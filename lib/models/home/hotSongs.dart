import 'package:json_annotation/json_annotation.dart';
import '../music/song.dart';
// import "song.dart";
part 'hotSongs.g.dart';

@JsonSerializable()
class HotSongs {
  HotSongs();

  num code;
  List<Song> songs;

  factory HotSongs.fromJson(Map<String, dynamic> json) =>
      _$HotSongsFromJson(json);
  Map<String, dynamic> toJson() => _$HotSongsToJson(this);
}
