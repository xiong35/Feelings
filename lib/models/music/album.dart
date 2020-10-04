import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
    Album();

    num id;
    String name;
    String picUrl;
    List<String> tns;
    
    factory Album.fromJson(Map<String,dynamic> json) => _$AlbumFromJson(json);
    Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
