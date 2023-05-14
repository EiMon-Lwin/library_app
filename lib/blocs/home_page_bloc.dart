import 'package:flutter/material.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/apply/library_app_apply_impl.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

import '../persistent/lists_dao/lists_dao_impl.dart';

class HomePageBloc extends ChangeNotifier {
  bool _dispose = false;
  List<ListsVO> _listsList = [];
  List<BooksVO> _carouselSliderList = [];

  ///Getter
  bool get getIsDispose => _dispose;

  List<ListsVO> get getListsList => _listsList;

  List<BooksVO> get getCarouselSliderList => _carouselSliderList;

  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;

  ///state Instance
  final LibraryAppApplyImpl _libraryAppApplyImpl = LibraryAppApplyImpl();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ListsDAOImpl _listDAOImpl = ListsDAOImpl();

  HomePageBloc() {
    _libraryAppApplyImpl.getListsVOFromNetwork(kPublishedDate);
    _libraryAppApplyImpl
        .getListsVOFromDataBaseStream(kPublishedDate)
        .listen((event) {
      if (event != null && event.isNotEmpty) {
        _listsList = event ?? [];

        notifyListeners();
      }
    });

    _libraryAppApplyImpl
        .getCarouselSliderBooksListFromDatabaseStream()
        .listen((event) {
      if (event != null && event.isNotEmpty) {
        _carouselSliderList = event;
        notifyListeners();
      }
    });
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  void whenTappedFavIcon(String title, String listName) {
    final selectedList = _listDAOImpl.getListOfListsBox.get(listName);

    if (selectedList != null) {
      List<BooksVO> books = selectedList.books ?? [];

      for (var element in books) {
        if (element.title == title) {
          if (element.isSelected != null) {
            element.isSelected = !(element.isSelected ?? false);
          }

          notifyListeners();
        }
      }

      _listDAOImpl.save(_listsList);
      notifyListeners();
    }
  }

  void showCarouselSlider(BooksVO booksVO, String listName) {
    booksVO.bookListName = listName;
    _libraryAppApplyImpl.saveCarouselBooks(booksVO);
    notifyListeners();
  }
}
