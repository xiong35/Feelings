import 'package:json_annotation/json_annotation.dart';
import '../music/song.dart';
// import "song.dart";
part 'recommendSongsData.g.dart';

@JsonSerializable()
class RecommendSongsData {
  RecommendSongsData();

  List<Song> dailySongs;

  factory RecommendSongsData.fromJson(
          Map<String, dynamic> json) =>
      _$RecommendSongsDataFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RecommendSongsDataToJson(this);
}
