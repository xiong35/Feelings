import 'package:json_annotation/json_annotation.dart';

part 'lyricData.g.dart';

@JsonSerializable()
class LyricData {
    LyricData();

    String lyric;
    
    factory LyricData.fromJson(Map<String,dynamic> json) => _$LyricDataFromJson(json);
    Map<String, dynamic> toJson() => _$LyricDataToJson(this);
}
