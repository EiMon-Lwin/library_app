import 'package:flutter/foundation.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/persistent/favorite_dao/favorite_dao_impl.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';

import '../data/apply/library_app_apply.dart';
import '../data/apply/library_app_apply_impl.dart';


class LibraryPageBloc extends ChangeNotifier {


  bool _dispose = false;
  // List<BooksVO> _favoriteBooks=[];
  List<ListsVO> _listsVO=[];
  List<dynamic> _keys=[];
  List<BooksVO> _favoritebooks=[];


  ///Variable Instance
  final LibraryAppApply _libraryAppApply=LibraryAppApplyImpl();
  final FavoriteDAOImpl _favoriteDAOImpl=FavoriteDAOImpl();
  final ListsDAOImpl _listsDAOImpl=ListsDAOImpl();
  final LibraryAppApplyImpl _libraryAppApplyImpl=LibraryAppApplyImpl();



  ///Getter
  bool get getIsDispose => _dispose;
 // List<BooksVO> get getFavoriteBooksList => _favoriteBooks;
  List<dynamic> get getKeys => _keys;
  List<ListsVO>  get getListVoForLibrary => _listsVO;




  LibraryPageBloc(){

    //_keys=_favoriteDAOImpl.getFavoriteBooksBox.keys.toList();


      //for(dynamic key in _keys) {

        // _libraryAppApplyImpl.getListsVOFromNetwork(kPublishedDate).then((value)  {
        //   if(value !=null && value.isNotEmpty){
        //     _listsList=value;
        //     notifyListeners();
        //   }
        // });

      //   _libraryAppApply.getFavoriteBooksFromDataBaseStream(key).listen((
      //       event) {
      //     _favoriteBooks = event ?? [];
      //     print("#############################${_favoriteBooks}");
      //     notifyListeners();
      //   });
      // }
    _libraryAppApplyImpl
        .getListsVOFromDataBaseStream(kPublishedDate)
        .listen((event) {
      if (event?.isNotEmpty ?? false) {
        for(ListsVO listsVO in event!)
          {
            List<BooksVO> books=listsVO.books ?? [];
            var temp=books.where((element) => element.isSelected=true).toList();
            listsVO.books=temp;

          }
        _listsVO=event;


        notifyListeners();
      }
    });



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
