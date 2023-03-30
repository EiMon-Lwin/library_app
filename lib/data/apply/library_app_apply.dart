import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';

import '../vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../vos/home_screen_api_vos/results_vo/results_vo.dart';
import '../vos/search_api_vos/items_vo/items_vo.dart';

abstract class LibraryAppApply {
  ///From Network
  Future<ResultsVO?> getResultsVOFromNetwork(String publishedDate);

  Future<List<ItemsVO>?> getItemListFromNetwork(String search);

  Future<List<ListsVO>?> getListsVOFromNetwork(String publishedDate);

  // Future<List<BooksVO>?> getBooksVO(String publishedDate);

  ///From Database
  Stream<ResultsVO?> getResultsVOFromDataBaseStream(String publishedDate);

  Stream<List<ListsVO>?> getListsVOFromDataBaseStream(String publishedDate);

  Stream<List<BooksVO>?> getFavoriteBooksFromDataBaseStream(String bookKey);

  void saveList(List<ListsVO> listOfLists);

  void saveSearchHistory(String query);

  List<String>? getSearchHistoryList();
}
