import 'package:hive/hive.dart';

import '../../../consts/persistent_const.dart';
import '../home_screen_api_vos/books_vo/books_vo.dart';


part 'shelf_vo.g.dart';
@HiveType(typeId: kShelfTypeId)
class ShelfVO{



  @HiveField(0)
  String? shelfName;

  @HiveField(1)
  List<BooksVO>? shelfBooks;

  ShelfVO( this.shelfName, this.shelfBooks);
}