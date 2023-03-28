import 'package:library_app/data/apply/library_app_apply.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import 'package:library_app/data/vos/search_api_vos/items_vo/items_vo.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';
import 'package:library_app/persistent/result_dao/result_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/data_agent/library_app_data_agent_impl.dart';
import '../../network/data_agent/library_app_data_agent.dart';

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


//  final FavoriteBooksDAO _favoriteBooksDAO = FavoriteBooksListDAOImpl();
  // @override
  // Future<List<BooksVO>?> getBooksVO(String publishedDate) {
  //   return _homePageDataAgent.getBooksVO(publishedDate);
  // }


  @override
  Future<ResultsVO?> getResultsVO(String publishedDate) {
    return _libraryAppDataAgent.getResultsVO(publishedDate).then((value) {
      // var temp = value;
      // if (temp != null) {
      //   _resultsDAO.save(temp);
      // }
      // return temp;
      return value;
    });
  }

  @override
  Future<List<ListsVO>?> getListsVO(String publishedDate) {
    return _libraryAppDataAgent.getListsVO(publishedDate).then((value) {
      var temp=value;
      if(temp !=null){
        _listsDAO.save(temp);
      }
      return temp;
    });
  }



  @override
  Stream<ResultsVO?> getResultsVOFromDataBaseStream(String publishedDate) {
    return _resultsDAO
        .watchResultsVOBox()
        .startWith(_resultsDAO.getResultsVOFromDatabaseStream(publishedDate))
        .map((event) => _resultsDAO.getResultsVOFromDatabase(publishedDate));
  }

  // @override
  // Stream<List<BooksVO>?> getFavoriteBooksVOFromDataBaseStream() {
  //   return _favoriteBooksDAO
  //       .watchFavoriteBooksList()
  //       .startWith(_favoriteBooksDAO.getFavoriteBooksListFromDataBaseStream())
  //       .map((event) => _favoriteBooksDAO.getFavoriteBooksListFromDataBase());
  // }

  @override
  Stream<List<ListsVO>?> getListsVOFromDataBaseStream(String publishedDate) {
    getListsVO(publishedDate);
    return _listsDAO
        .watchListsBox()
        .startWith(_listsDAO.getListOfListsFromDataBaseStream(publishedDate))
        .map((event) => _listsDAO.getListOfListsFromDataBase(publishedDate));
  }

  @override
  List<String>? getSearchHistoryList() =>_searchDao.getSearchHistory();

  @override
  void saveSearchHistory(String query) {
    _searchDao.save(query);
  }

  @override
  Future<List<ItemsVO>?> getItemListFromNetwork(String search)  =>
      _libraryAppDataAgent.getItemsVO(search).then((value) => value);

}
