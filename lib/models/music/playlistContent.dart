import 'package:json_annotation/json_annotation.dart';
import "playlistContentData.dart";
part 'playlistContent.g.dart';

@JsonSerializable()
class PlaylistContent {
    PlaylistContent();

    num code;
    PlaylistContentData playlist;
    
    factory PlaylistContent.fromJson(Map<String,dynamic> json) => _$PlaylistContentFromJson(json);
    Map<String, dynamic> toJson() => _$PlaylistContentToJson(this);
}
