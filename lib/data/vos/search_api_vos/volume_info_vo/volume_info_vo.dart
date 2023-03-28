
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/search_api_vos/image_links_vo/image_links_vo.dart';
import 'package:library_app/data/vos/search_api_vos/industry_identifiers_vo/industry_identifiers_vo.dart';
import 'package:library_app/data/vos/search_api_vos/panelizationSummary_vo/panelization_summary_vo.dart';
import 'package:library_app/data/vos/search_api_vos/reading_modes_vo/reading_modes_vo.dart';
import 'package:library_app/data/vos/search_api_vos/series_info_vo/series_info_vo.dart';

part 'volume_info_vo.g.dart';
@JsonSerializable()
class VolumeInfoVO {

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "publishedDate")
  String? publishedDate;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "industryIdentifiers")
  List<IndustryIdentifiersVO>? industryIdentifiers;

  @JsonKey(name: "readingModes")
  ReadingModesVO? readingModes;

  @JsonKey(name: "pageCount")
  int? pageCount;

  @JsonKey(name: "printType")
  String? printType;

  @JsonKey(name: "categories")
  List<String>? categories;

  @JsonKey(name: "maturityRating")
  String? maturityRating;

  @JsonKey(name: "allowAnonLogging")
  bool? allowAnonLogging;

  @JsonKey(name: "contentVersion")
  String? contentVersion;

  @JsonKey(name: "panelizationSummary")
  PanelizationSummaryVO? panelizationSummary;

  @JsonKey(name: "imageLinks")
  ImageLinksVO? imageLinks;

  @JsonKey(name: "language")
  String? language;

  @JsonKey(name: "previewLink")
  String? previewLink;

  @JsonKey(name: "infoLink")
  String? infoLink;

  @JsonKey(name: "canonicalVolumeLink")
  String? canonicalVolumeLink;

  @JsonKey(name: "authors")
  List<String>? authors;

  @JsonKey(name: "seriesInfo")
  SeriesInfoVO? seriesInfo;

  @JsonKey(name: "averageRating")
  int? averageRating;

  @JsonKey(name: "ratingsCount")
  int? ratingsCount;

  @JsonKey(name: "subtitle")
  String? subtitle;

  VolumeInfoVO(
      {this.title,
        this.publisher,
        this.publishedDate,
        this.description,
        this.industryIdentifiers,
        this.readingModes,
        this.pageCount,
        this.printType,
        this.categories,
        this.maturityRating,
        this.allowAnonLogging,
        this.contentVersion,
        this.panelizationSummary,
        this.imageLinks,
        this.language,
        this.previewLink,
        this.infoLink,
        this.canonicalVolumeLink,
        this.authors,
        this.seriesInfo,
        this.averageRating,
        this.ratingsCount,
        this.subtitle});

  factory VolumeInfoVO.fromJson(Map<String, dynamic> json) =>_$VolumeInfoVOFromJson(json);

  Map<String, dynamic> toJson() =>_$VolumeInfoVOToJson(this);
}

