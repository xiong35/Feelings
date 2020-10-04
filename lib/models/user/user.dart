import 'package:json_annotation/json_annotation.dart';
import "userPoint.dart";
import "profile.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num level;
    UserPoint userPoint;
    Profile profile;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
