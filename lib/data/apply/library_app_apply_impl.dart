import 'package:library_app/data/apply/library_app_apply.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import 'package:library_app/data/vos/search_api_vos/items_vo/items_vo.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';
import 'package:library_app/persistent/result_dao/result_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/data_agent/library_app_data_agent_impl.dart';
import '../../network/data_agent/library_app_data_agent.dart';

import '../../persistent/favorite_dao/favorite_dao.dart';
import '../../persistent/favorite_dao/favorite_dao_impl.dart';
import '../../persistent/lists_dao/lists_dao.dart';
import '../../persistent/result_dao/result_dao_impl.dart';
import '../../persistent/search_dao/search_dao.dart';
import '../../persistent/search_dao/search_dao_impl.dart';

class LibraryAppApplyImpl extends LibraryAppApply {
  LibraryAppApplyImpl._();

  static final LibraryAppApplyImpl _singleton = LibraryAppApplyImpl._();

  factory LibraryAppApplyImpl() => _singleton;
  final LibraryAppDataAgent _libraryAppDataAgent = LibraryAppDataAgentImpl();

  final ResultsDAO _resultsDAO = ResultDAOImpl();
  final ListsDAO _listsDAO = ListsDAOImpl();
  final SearchHistoryDAO _searchDao = SearchHistoryDAOImpl();

  final FavoriteDAO _favoriteBooksDAO = FavoriteDAOImpl();

  ///Network Layer

  @override
  Future<ResultsVO?> getResultsVOFromNetwork(String publishedDate) {
    return _libraryAppDataAgent.getResultsVO(publishedDate).then((value) {
      return value;
    });
  }

  @override
  Future<List<ListsVO>?> getListsVOFromNetwork(String publishedDate) =>
     _libraryAppDataAgent.getListsVO(publishedDate).then((value)  {
      var temp = _listsDAO.getListOfListsFromDataBase(publishedDate) ?? [];

      if ( temp.isEmpty ) {
        _listsDAO.save(value!);
      }
      return value;
    });


  @override
  Future<List<ItemsVO>?> getItemListFromNetwork(String search) =>
      _libraryAppDataAgent.getItemsVO(search).then((value) => value);

  ///Database Layer
  @override
  Stream<ResultsVO?> getResultsVOFromDataBaseStream(String publishedDate) {
    return _resultsDAO
        .watchResultsVOBox()
        .startWith(_resultsDAO.getResultsVOFromDatabaseStream(publishedDate))
        .map((event) => _resultsDAO.getResultsVOFromDatabase(publishedDate));
  }

  @override
  Stream<List<ListsVO>?> getListsVOFromDataBaseStream(String publishedDate) {
    getListsVOFromNetwork(publishedDate);
    return _listsDAO
        .watchListsBox()
        .startWith(_listsDAO.getListOfListsFromDataBaseStream(publishedDate))
        .map((event) => _listsDAO.getListOfListsFromDataBase(publishedDate));
  }

  @override
  List<String>? getSearchHistoryList() => _searchDao.getSearchHistory();

  @override
  void saveSearchHistory(String query) {
    _searchDao.save(query);
  }

  void saveList(List<ListsVO> listOfLists) =>
      _listsDAO.save(listOfLists);

  @override
  Stream<List<BooksVO>?> getFavoriteBooksFromDataBaseStream(String bookKey) {
    return _favoriteBooksDAO
        .watchFavoriteBooksBox()
        .startWith(
            _favoriteBooksDAO.getFavoriteBookListFromDataBaseStream(bookKey))
        .map((event) =>
            _favoriteBooksDAO.getFavoriteBookListFromDataBase(bookKey));
  }
}
