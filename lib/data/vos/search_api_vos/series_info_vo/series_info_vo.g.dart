// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesInfoVO _$SeriesInfoVOFromJson(Map<String, dynamic> json) => SeriesInfoVO(
      kind: json['kind'] as String?,
      bookDisplayNumber: json['bookDisplayNumber'] as String?,
      volumeSeries: (json['volumeSeries'] as List<dynamic>?)
          ?.map((e) => VolumeSeriesVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesInfoVOToJson(SeriesInfoVO instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'bookDisplayNumber': instance.bookDisplayNumber,
      'volumeSeries': instance.volumeSeries,
    };
