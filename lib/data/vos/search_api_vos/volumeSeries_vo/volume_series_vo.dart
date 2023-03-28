
import 'package:json_annotation/json_annotation.dart';

part 'volume_series_vo.g.dart';
@JsonSerializable()
class VolumeSeriesVO {

  @JsonKey(name: "seriesId")
  String? seriesId;

  @JsonKey(name: "seriesBookType")
  String? seriesBookType;

  @JsonKey(name: "orderNumber")
  int? orderNumber;

  VolumeSeriesVO({this.seriesId, this.seriesBookType, this.orderNumber});

  factory VolumeSeriesVO.fromJson(Map<String, dynamic> json) =>_$VolumeSeriesVOFromJson(json);

   Map<String, dynamic> toJson() =>_$VolumeSeriesVOToJson(this);
}