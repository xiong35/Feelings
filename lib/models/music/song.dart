import 'package:json_annotation/json_annotation.dart';
import "artistBrief.dart";
import "album.dart";
part 'song.g.dart';

@JsonSerializable()
class Song {
    Song();

    String name;
    num id;
    List<ArtistBrief> ar;
    Album al;
    num mv;
    
    factory Song.fromJson(Map<String,dynamic> json) => _$SongFromJson(json);
    Map<String, dynamic> toJson() => _$SongToJson(this);
}
