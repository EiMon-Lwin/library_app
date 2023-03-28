

import 'package:json_annotation/json_annotation.dart';

part 'panelization_summary_vo.g.dart';
@JsonSerializable()
class PanelizationSummaryVO {

  @JsonKey(name: "containsEpubBubbles")
  bool? containsEpubBubbles;

  @JsonKey(name: "containsImageBubbles")
  bool? containsImageBubbles;

  @JsonKey(name: "epubBubbleVersion")
  String? epubBubbleVersion;

  @JsonKey(name: "imageBubbleVersion")
  String? imageBubbleVersion;

  PanelizationSummaryVO(
      {this.containsEpubBubbles,
        this.containsImageBubbles,
        this.epubBubbleVersion,
        this.imageBubbleVersion});

  factory PanelizationSummaryVO.fromJson(Map<String, dynamic> json) =>_$PanelizationSummaryVOFromJson(json);

  Map<String, dynamic> toJson() =>_$PanelizationSummaryVOToJson(this);
}

