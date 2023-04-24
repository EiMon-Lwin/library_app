import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

import '../../data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import '../../data/vos/search_api_vos/items_vo/items_vo.dart';

abstract class LibraryAppDataAgent {
  Future<ResultsVO?> getResultsVO(String publishedDate);

  Future<List<ListsVO>?> getListsVO(String publishedDate);

  //Future<List<BooksVO>?>  getBooksVO(String publishedDate);

  Future<List<ItemsVO>?> getItemsVO(String search);
}
