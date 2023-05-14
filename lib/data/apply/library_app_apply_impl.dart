import 'package:library_app/data/apply/library_app_apply.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import 'package:library_app/data/vos/search_api_vos/items_vo/items_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/persistent/carousel_slider_list_dao/carousel_slider_list_dao.dart';
import 'package:library_app/persistent/carousel_slider_list_dao/carousel_slider_list_dao_Impl.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';
import 'package:library_app/persistent/result_dao/result_dao.dart';
import 'package:library_app/persistent/shelf_dao/shelf_dao.dart';
import 'package:library_app/persistent/shelf_dao/shelf_dao_impl.dart';
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

 // final ResultsDAO _resultsDAO = ResultDAOImpl();
  final ListsDAO _listsDAO = ListsDAOImpl();
  final SearchHistoryDAO _searchDao = SearchHistoryDAOImpl();
  final ShelfDAO _shelfDAO = ShelfDAOImpl();
  final CarouselSliderListDao _carouselSliderListDao =
      CarouselSliderListDaoImpl();

  ///Network Layer

  // @override
  // Future<ResultsVO?> getResultsVOFromNetwork(String publishedDate) {
  //   return _libraryAppDataAgent.getResultsVO(publishedDate).then((value) {
  //     return value;
  //   });
  // }

  @override
  Future<List<ListsVO>?> getListsVOFromNetwork(String publishedDate) =>
      _libraryAppDataAgent.getListsVO(publishedDate).then((value) {
        print("Meow*********");
        var temp = _listsDAO.getListOfListsFromDataBase(publishedDate) ?? [];

        if (temp.isEmpty) {
          _listsDAO.save(value!);
        }
        return value;
      });

  @override
  Future<List<ItemsVO>?> getItemListFromNetwork(String search) =>
      _libraryAppDataAgent.getItemsVO(search).then((value) => value);

  ///Database Layer
  // @override
  // Stream<ResultsVO?> getResultsVOFromDataBaseStream(String publishedDate) {
  //   return _resultsDAO
  //       .watchResultsVOBox()
  //       .startWith(_resultsDAO.getResultsVOFromDatabaseStream(publishedDate))
  //       .map((event) => _resultsDAO.getResultsVOFromDatabase(publishedDate));
  // }

  @override
  Stream<List<ListsVO>?> getListsVOFromDataBaseStream(String publishedDate) {
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

  @override
  void saveList(List<ListsVO> listOfLists) => _listsDAO.save(listOfLists);

  @override
  Stream<List<ShelfVO>?> getShelfVOFromDataBaseStream() {
    return _shelfDAO
        .watchShelfBox()
        .startWith(_shelfDAO.getListOfShelfVOFromDataBaseStream())
        .map((event) => _shelfDAO.getListOfShelfVOFromDataBase());
  }

  @override
  void createShelf(String shelfName, List<BooksVO> books) {
    ShelfVO shelf = ShelfVO(shelfName, books);
    return _shelfDAO.save(shelf);
  }

  @override
  Stream<List<BooksVO>?> getCarouselSliderBooksListFromDatabaseStream() {
    return _carouselSliderListDao
        .watchCarouselSliderListBox()
        .startWith(
            _carouselSliderListDao.getCarouselSliderListFromDatabaseStream())
        .map((event) =>
            _carouselSliderListDao.getCarouselSliderListFromDatabase());
  }

  @override
  void saveCarouselBooks(BooksVO books) {
    return _carouselSliderListDao.save(books);
  }
}
