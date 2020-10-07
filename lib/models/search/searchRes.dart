import 'package:json_annotation/json_annotation.dart';
import "searchResult.dart";
part 'searchRes.g.dart';

@JsonSerializable()
class SearchRes {
    SearchRes();

    SearchResult result;
    num code;
    
    factory SearchRes.fromJson(Map<String,dynamic> json) => _$SearchResFromJson(json);
    Map<String, dynamic> toJson() => _$SearchResToJson(this);
}
