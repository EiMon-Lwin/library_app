import 'package:flutter/foundation.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';


import '../data/apply/library_app_apply_impl.dart';

class LibraryPageBloc extends ChangeNotifier {
  bool _dispose = false;

  List<ListsVO> _lists = [];

  ///Variable Instance
  final ListsDAOImpl _listsDAOImpl = ListsDAOImpl();

  final LibraryAppApplyImpl _libraryAppApplyImpl = LibraryAppApplyImpl();

  ///Getter
  bool get getIsDispose => _dispose;

  List<ListsVO> get getListVoForLibrary => _lists;

  LibraryPageBloc() {
    _libraryAppApplyImpl
        .getListsVOFromDataBaseStream(kPublishedDate)
        .listen((event) {
      if (event != null && event.isNotEmpty) {
        _lists = event ?? [];

        notifyListeners();
      }
    });

    var updatedLists = _lists
        .map((listsVO) {
          var selectedBooks = listsVO.books
              ?.where((bookVO) => bookVO.isSelected == true)
              .toList();
          listsVO.books = selectedBooks;
          return listsVO;
        })
        .where((listsVO) => listsVO.books != null && listsVO.books!.isNotEmpty)
        .toList();
    _lists = updatedLists;
    notifyListeners();
  }

  void whenTappedFavIcon(String title, String listName) {
    final selectedList = _listsDAOImpl.getListOfListsBox.get(listName);
    _libraryAppApplyImpl.getListsVOFromDataBaseStream(kPublishedDate);

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

      _listsDAOImpl.save(_lists);
      notifyListeners();
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
