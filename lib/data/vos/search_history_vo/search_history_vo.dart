import 'package:hive/hive.dart';

import '../../../consts/persistent_const.dart';

@HiveType(typeId: kSearchHistoryTypeId)
class SearchHistoryVO{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? query;
}