// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panelization_summary_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelizationSummaryVO _$PanelizationSummaryVOFromJson(
        Map<String, dynamic> json) =>
    PanelizationSummaryVO(
      containsEpubBubbles: json['containsEpubBubbles'] as bool?,
      containsImageBubbles: json['containsImageBubbles'] as bool?,
      epubBubbleVersion: json['epubBubbleVersion'] as String?,
      imageBubbleVersion: json['imageBubbleVersion'] as String?,
    );

Map<String, dynamic> _$PanelizationSummaryVOToJson(
        PanelizationSummaryVO instance) =>
    <String, dynamic>{
      'containsEpubBubbles': instance.containsEpubBubbles,
      'containsImageBubbles': instance.containsImageBubbles,
      'epubBubbleVersion': instance.epubBubbleVersion,
      'imageBubbleVersion': instance.imageBubbleVersion,
    };
