import 'package:json_annotation/json_annotation.dart';
import "hotItem.dart";
part 'hotResult.g.dart';

@JsonSerializable()
class HotResult {
    HotResult();

    List<HotItem> hots;
    
    factory HotResult.fromJson(Map<String,dynamic> json) => _$HotResultFromJson(json);
    Map<String, dynamic> toJson() => _$HotResultToJson(this);
}
