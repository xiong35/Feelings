import 'package:json_annotation/json_annotation.dart';

part 'songId.g.dart';

@JsonSerializable()
class SongId {
    SongId();

    num id;
    
    factory SongId.fromJson(Map<String,dynamic> json) => _$SongIdFromJson(json);
    Map<String, dynamic> toJson() => _$SongIdToJson(this);
}
