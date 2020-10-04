import 'package:json_annotation/json_annotation.dart';
import "songUrlData.dart";
part 'songUrls.g.dart';

@JsonSerializable()
class SongUrls {
    SongUrls();

    List<SongUrlData> data;
    num code;
    
    factory SongUrls.fromJson(Map<String,dynamic> json) => _$SongUrlsFromJson(json);
    Map<String, dynamic> toJson() => _$SongUrlsToJson(this);
}
