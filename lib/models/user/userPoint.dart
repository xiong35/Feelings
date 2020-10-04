import 'package:json_annotation/json_annotation.dart';

part 'userPoint.g.dart';

@JsonSerializable()
class UserPoint {
    UserPoint();

    num userId;
    num balance;
    num updateTime;
    num version;
    num status;
    
    factory UserPoint.fromJson(Map<String,dynamic> json) => _$UserPointFromJson(json);
    Map<String, dynamic> toJson() => _$UserPointToJson(this);
}
