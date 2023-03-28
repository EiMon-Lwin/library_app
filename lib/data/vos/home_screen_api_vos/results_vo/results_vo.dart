import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../consts/persistent_const.dart';
import '../lists_vo/lists_vo.dart';

part 'results_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: kHiveTypeForResultsTypeId)
class ResultsVO {

  @JsonKey(name: "bestsellers_date")
  @HiveField(0)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(1)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(2)
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  @HiveField(3)
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  @HiveField(4)
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  @HiveField(5)
  List<ListsVO>? lists;

  ResultsVO(
      {this.bestsellersDate,
        this.publishedDate,
        this.publishedDateDescription,
        this.previousPublishedDate,
        this.nextPublishedDate,
        this.lists});

   factory ResultsVO.fromJson(Map<String, dynamic> json) =>_$ResultsVOFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsVOToJson(this);
}