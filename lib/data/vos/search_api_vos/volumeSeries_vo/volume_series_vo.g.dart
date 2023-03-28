// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_series_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeSeriesVO _$VolumeSeriesVOFromJson(Map<String, dynamic> json) =>
    VolumeSeriesVO(
      seriesId: json['seriesId'] as String?,
      seriesBookType: json['seriesBookType'] as String?,
      orderNumber: json['orderNumber'] as int?,
    );

Map<String, dynamic> _$VolumeSeriesVOToJson(VolumeSeriesVO instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'seriesBookType': instance.seriesBookType,
      'orderNumber': instance.orderNumber,
    };
