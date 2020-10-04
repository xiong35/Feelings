import 'package:json_annotation/json_annotation.dart';
import "userLvData.dart";
part 'userLv.g.dart';

@JsonSerializable()
class UserLv {
    UserLv();

    bool full;
    UserLvData data;
    num code;
    
    factory UserLv.fromJson(Map<String,dynamic> json) => _$UserLvFromJson(json);
    Map<String, dynamic> toJson() => _$UserLvToJson(this);
}
