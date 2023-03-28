
import 'package:json_annotation/json_annotation.dart';

part 'epub_vo.g.dart';
@JsonSerializable()
class EpubVO {

  @JsonKey(name: "isAvailable")
  bool? isAvailable;

  @JsonKey(name: "acsTokenLink")
  String? acsTokenLink;

  EpubVO({this.isAvailable, this.acsTokenLink});

  factory EpubVO.fromJson(Map<String, dynamic> json) =>_$EpubVOFromJson(json);

  Map<String, dynamic> toJson() =>_$EpubVOToJson(this);
}