import 'package:json_annotation/json_annotation.dart';

part 'userLvData.g.dart';

@JsonSerializable()
class UserLvData {
    UserLvData();

    num userId;
    String info;
    num progress;
    num nextPlayCount;
    num nextLoginCount;
    num nowPlayCount;
    num nowLoginCount;
    num level;
    
    factory UserLvData.fromJson(Map<String,dynamic> json) => _$UserLvDataFromJson(json);
    Map<String, dynamic> toJson() => _$UserLvDataToJson(this);
}
