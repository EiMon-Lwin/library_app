
import 'package:json_annotation/json_annotation.dart';

part 'list_price_vo.g.dart';
@JsonSerializable()
class ListPriceVO {

  @JsonKey(name: "amountInMicros")
  int? amountInMicros;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  ListPriceVO({this.amountInMicros, this.currencyCode});

  factory ListPriceVO.fromJson(Map<String, dynamic> json) =>_$ListPriceVOFromJson(json);

  Map<String, dynamic> toJson() =>_$ListPriceVOToJson(this);
}