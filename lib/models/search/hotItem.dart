import 'package:json_annotation/json_annotation.dart';

part 'hotItem.g.dart';

@JsonSerializable()
class HotItem {
    HotItem();

    String first;
    num second;
    String third;
    num iconType;
    
    factory HotItem.fromJson(Map<String,dynamic> json) => _$HotItemFromJson(json);
    Map<String, dynamic> toJson() => _$HotItemToJson(this);
}
