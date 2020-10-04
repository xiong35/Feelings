import 'package:json_annotation/json_annotation.dart';
import "lyricData.dart";
part 'lyric.g.dart';

@JsonSerializable()
class Lyric {
    Lyric();

    LyricData lrc;
    num code;
    
    factory Lyric.fromJson(Map<String,dynamic> json) => _$LyricFromJson(json);
    Map<String, dynamic> toJson() => _$LyricToJson(this);
}
