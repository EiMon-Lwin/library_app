import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/search_api_vos/list_price_vo/list_price_vo.dart';


part 'offers_vo.g.dart';
@JsonSerializable()
class OffersVO {

  @JsonKey(name: "finskyOfferType")
  int? finskyOfferType;

  @JsonKey(name: "listPrice")
  ListPriceVO? listPrice;

  @JsonKey(name: "retailPrice")
  ListPriceVO? retailPrice;

  OffersVO({this.finskyOfferType, this.listPrice, this.retailPrice});

 factory OffersVO.fromJson(Map<String, dynamic> json) =>_$OffersVOFromJson(json);

  Map<String, dynamic> toJson() =>_$OffersVOToJson(this);
}