import 'package:json_annotation/json_annotation.dart';
import "song.dart";
part 'songDetail.g.dart';

@JsonSerializable()
class SongDetail {
    SongDetail();

    List<Song> songs;
    num code;
    
    factory SongDetail.fromJson(Map<String,dynamic> json) => _$SongDetailFromJson(json);
    Map<String, dynamic> toJson() => _$SongDetailToJson(this);
}
