import 'package:json_annotation/json_annotation.dart';
import "recommendSongsData.dart";
part 'recommendSongs.g.dart';

@JsonSerializable()
class RecommendSongs {
    RecommendSongs();

    num code;
    RecommendSongsData data;
    
    factory RecommendSongs.fromJson(Map<String,dynamic> json) => _$RecommendSongsFromJson(json);
    Map<String, dynamic> toJson() => _$RecommendSongsToJson(this);
}
