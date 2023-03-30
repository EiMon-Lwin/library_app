import 'package:flutter/material.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/apply/library_app_apply_impl.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';

import '../persistent/lists_dao/lists_dao_impl.dart';

class HomePageBloc extends ChangeNotifier {
  bool _dispose = false;
  List<ListsVO> _listsList = [];
  ResultsVO? _resultsVO;

  ///Getter
  bool get getIsDispose => _dispose;

  List<ListsVO> get getListsList => _listsList;


  ///state Instance
  final LibraryAppApplyImpl _libraryAppApplyImpl = LibraryAppApplyImpl();
  final ListsDAOImpl _listDAOImpl=ListsDAOImpl();


  HomePageBloc() {
    // _libraryAppApplyImpl
    //     .getListsVOFromDataBaseStream(kPublishedDate)
    //     .listen((event) {
    //   if (event?.isNotEmpty ?? false) {
    //     _listsList = event ?? [];
    //
    //     notifyListeners();
    //   }
    // });

    //_libraryAppApplyImpl.getResultsVO(kPublishedDate);

    // _libraryAppApplyImpl.getResultsVOFromDataBaseStream(kPublishedDate).listen((event) {
    //   _resultsVO=event;
    //   if(_resultsVO !=null){
    //     var temp=_resultsVO?.lists?? [];
    //     if(temp.isNotEmpty){
    //       _listsList=temp;
    //       notifyListeners();
    //     }
    //   }
    // });

    _libraryAppApplyImpl.getListsVOFromNetwork(kPublishedDate).then((value)  {
     if(value !=null && value.isNotEmpty){
       _listsList=value;
       notifyListeners();
     }
    });

    // _libraryAppApplyImpl.getBooksVO(kPublishedDate).then((value) {
    //   if(value !=null && value.isNotEmpty){
    //     _booksList=value;
    //     notifyListeners();
    //   }
    // });
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

  whenTappedFavIcon(String title,int listId) {
    final selectedList = _listDAOImpl.getListOfListsBox.get(listId);
    if (selectedList != null ) {

        List<BooksVO> books = selectedList.books ?? [];
        for (var element in books) {
          if (element.title == title) {
            element.isSelected = element.isSelected ?? false;
            notifyListeners();
          }
        }
      }
      _libraryAppApplyImpl.saveList(_listsList);
      notifyListeners();
    }
  }

