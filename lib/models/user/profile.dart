import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  String avatarImgIdStr;
  num avatarImgId;
  num gender;
  String nickname;
  num vipType;
  String avatarUrl;
  String signature;
  num followeds;
  num follows;
  num userId;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
