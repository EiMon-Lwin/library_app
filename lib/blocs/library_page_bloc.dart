import 'package:flutter/foundation.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';

import '../data/apply/library_app_apply.dart';
import '../data/apply/library_app_apply_impl.dart';


class LibraryPageBloc extends ChangeNotifier {
  bool _dispose = false;
  List<BooksVO> _favoriteBooks=[];

  ///Getter
  bool get getIsDispose => _dispose;
  List<BooksVO> get getFavoriteBooksList => _favoriteBooks;


  ///Variable Instance
  LibraryAppApply _libraryAppApply=LibraryAppApplyImpl();


  LibraryPageBloc(){
    // _libraryAppApply.getFavoriteBooksVOFromDataBaseStream().listen((event) {
    //   _favoriteBooks=event ?? [];
    // });

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
