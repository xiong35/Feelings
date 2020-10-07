import 'package:json_annotation/json_annotation.dart';
import "hotResult.dart";
part 'hotRes.g.dart';

@JsonSerializable()
class HotRes {
    HotRes();

    num code;
    HotResult result;
    
    factory HotRes.fromJson(Map<String,dynamic> json) => _$HotResFromJson(json);
    Map<String, dynamic> toJson() => _$HotResToJson(this);
}
