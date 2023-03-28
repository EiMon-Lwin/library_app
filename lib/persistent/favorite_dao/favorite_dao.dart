import 'dart:core';

import '../../data/vos/home_screen_api_vos/books_vo/books_vo.dart';

abstract class FavoriteDAO{
  void save( BooksVO favoriteBook);

  Stream watchFavoriteBooksBox();

  BooksVO? getFavoriteBookFromDataBase();

  Stream<BooksVO> getFavoriteBookFromDataBaseStream();
}