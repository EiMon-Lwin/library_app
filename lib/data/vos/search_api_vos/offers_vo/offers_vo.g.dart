// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersVO _$OffersVOFromJson(Map<String, dynamic> json) => OffersVO(
      finskyOfferType: json['finskyOfferType'] as int?,
      listPrice: json['listPrice'] == null
          ? null
          : ListPriceVO.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice: json['retailPrice'] == null
          ? null
          : ListPriceVO.fromJson(json['retailPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersVOToJson(OffersVO instance) => <String, dynamic>{
      'finskyOfferType': instance.finskyOfferType,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
    };
