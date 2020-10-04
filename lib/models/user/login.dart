import 'package:json_annotation/json_annotation.dart';
import "profile.dart";
part 'login.g.dart';

@JsonSerializable()
class Login {
    Login();

    String token;
    Profile profile;
    
    factory Login.fromJson(Map<String,dynamic> json) => _$LoginFromJson(json);
    Map<String, dynamic> toJson() => _$LoginToJson(this);
}
