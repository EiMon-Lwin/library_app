
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/search_api_vos/accessInfo_vo/accessInfo_vo.dart';
import 'package:library_app/data/vos/search_api_vos/saleInfo_vo/saleInfo_vo.dart';
import 'package:library_app/data/vos/search_api_vos/search_info_vo/search_info_vo.dart';
import 'package:library_app/data/vos/search_api_vos/volume_info_vo/volume_info_vo.dart';

part 'items_vo.g.dart';
@JsonSerializable()
class ItemsVO {

  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "id" )
  String? id;

  @JsonKey(name: "etag")
  String? etag;

  @JsonKey(name: "selfLink")
  String? selfLink;

  @JsonKey(name: "volumeInfo")
  VolumeInfoVO? volumeInfo;

  @JsonKey(name: "saleInfo")
  SaleInfoVO? saleInfo;

  @JsonKey(name: "accessInfo")
  AccessInfoVO? accessInfo;

  @JsonKey(name: "searchInfo")
  SearchInfoVO? searchInfo;

  ItemsVO(
      {this.kind,
        this.id,
        this.etag,
        this.selfLink,
        this.volumeInfo,
        this.saleInfo,
        this.accessInfo,
        this.searchInfo});

  factory ItemsVO.fromJson(Map<String, dynamic> json)=>_$ItemsVOFromJson(json);

  Map<String, dynamic> toJson()=>_$ItemsVOToJson(this);
}