import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/search_api_vos/items_vo/items_vo.dart';

part 'search_api_response.g.dart';
@JsonSerializable()
class SearchAPIResponse {
  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "totalItems")
  int? totalItems;

  @JsonKey(name: "items")
  List<ItemsVO>? items;

  SearchAPIResponse({this.kind, this.totalItems, this.items});

  factory SearchAPIResponse.fromJson(Map<String, dynamic> json) => _$SearchAPIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAPIResponseToJson(this);
}