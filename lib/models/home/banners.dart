import 'package:json_annotation/json_annotation.dart';
import "banner.dart";
part 'banners.g.dart';

@JsonSerializable()
class Banners {
    Banners();

    List<Banner> banners;
    
    factory Banners.fromJson(Map<String,dynamic> json) => _$BannersFromJson(json);
    Map<String, dynamic> toJson() => _$BannersToJson(this);
}
