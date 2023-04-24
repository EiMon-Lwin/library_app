import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';

import '../consts/strings.dart';

class DetailsPageBloc extends ChangeNotifier {
  /// Variable
  bool _dispose = false;
  String _imageLink = "";
  String _author = "";
  String _bookName = "";
  BooksVO? _booksVO;

  ///Getter
  bool get getIsDispose => _dispose;

  String get getImageLink => _imageLink;

  String get getAuthor => _author;

  String get getBookName => _bookName;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  DetailsPageBloc(BooksVO book) {
    _booksVO = book;
    _imageLink = _booksVO?.bookImage ?? kDefaultImageLink;
    _bookName = _booksVO?.title ?? "_";
    _author = _booksVO?.author ?? "_";
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
