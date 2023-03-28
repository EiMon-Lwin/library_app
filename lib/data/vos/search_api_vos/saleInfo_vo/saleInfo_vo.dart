
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/search_api_vos/list_price_vo/list_price_vo.dart';
import 'package:library_app/data/vos/search_api_vos/offers_vo/offers_vo.dart';

part 'saleInfo_vo.g.dart';
@JsonSerializable()
class SaleInfoVO {

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "saleability")
  String? saleability;

  @JsonKey(name: "isEbook")
  bool? isEbook;

  @JsonKey(name: "listPrice")
  ListPriceVO? listPrice;

  @JsonKey(name: "retailPrice")
  ListPriceVO? retailPrice;

  @JsonKey(name: "buyLink")
  String? buyLink;

  @JsonKey(name: "offers")
  List<OffersVO>? offers;

  SaleInfoVO(
      {this.country,
        this.saleability,
        this.isEbook,
        this.listPrice,
        this.retailPrice,
        this.buyLink,
        this.offers});

 factory SaleInfoVO.fromJson(Map<String, dynamic> json) =>_$SaleInfoVOFromJson(json);

  Map<String, dynamic> toJson() =>_$SaleInfoVOToJson(this);
}

