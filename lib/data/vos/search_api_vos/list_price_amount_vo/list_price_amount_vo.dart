
import 'package:json_annotation/json_annotation.dart';

part 'list_price_amount_vo.g.dart';
@JsonSerializable()
class ListPriceAmountVO {

  @JsonKey(name: "amount")
  int? amount;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  ListPriceAmountVO({this.amount, this.currencyCode});

 factory ListPriceAmountVO.fromJson(Map<String, dynamic> json) =>_$ListPriceAmountVOFromJson(json);
  Map<String, dynamic> toJson() =>_$ListPriceAmountVOToJson(this);
}
