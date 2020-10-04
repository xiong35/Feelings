import 'package:json_annotation/json_annotation.dart';

part 'artistBrief.g.dart';

@JsonSerializable()
class ArtistBrief {
    ArtistBrief();

    num id;
    String name;
    
    factory ArtistBrief.fromJson(Map<String,dynamic> json) => _$ArtistBriefFromJson(json);
    Map<String, dynamic> toJson() => _$ArtistBriefToJson(this);
}
