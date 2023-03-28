import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../consts/persistent_const.dart';
import '../books_vo/books_vo.dart';

part 'lists_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: kHiveTypeForListsTypeId)
class ListsVO {

  @JsonKey(name: "list_id")
  @HiveField(0)
  int? listId;

  @JsonKey(name: "list_name")
  @HiveField(1)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(2)
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  @HiveField(3)
  String? displayName;

  @JsonKey(name: "updated")
  @HiveField(4)
  String? updated;

  @JsonKey(name: "list_image")
  @HiveField(5)
  Object? listImage;

  @JsonKey(name: "list_image_width")
  @HiveField(6)
  Object? listImageWidth;

  @JsonKey(name: "list_image_height")
  @HiveField(7)
  Object? listImageHeight;

  @JsonKey(name: "books")
  @HiveField(8)
  List<BooksVO>? books;

  ListsVO(
      {this.listId,
        this.listName,
        this.listNameEncoded,
        this.displayName,
        this.updated,
        this.listImage,
        this.listImageWidth,
        this.listImageHeight,
        this.books});

  factory ListsVO.fromJson(Map<String, dynamic> json) =>_$ListsVOFromJson(json);

  Map<String, dynamic> toJson() =>_$ListsVOToJson(this);
}