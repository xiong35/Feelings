import 'package:json_annotation/json_annotation.dart';

part 'songUrlData.g.dart';

@JsonSerializable()
class SongUrlData {
    SongUrlData();

    num id;
    String url;
    num code;
    String type;
    String encodeType;
    
    factory SongUrlData.fromJson(Map<String,dynamic> json) => _$SongUrlDataFromJson(json);
    Map<String, dynamic> toJson() => _$SongUrlDataToJson(this);
}
