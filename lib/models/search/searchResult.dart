import 'package:json_annotation/json_annotation.dart';
import '../music/song.dart';
// import "song.dart";
part 'searchResult.g.dart';

@JsonSerializable()
class SearchResult {
  SearchResult();

  List queryCorrected;
  List<Song> songs;
  bool hasMore;
  num songCount;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
