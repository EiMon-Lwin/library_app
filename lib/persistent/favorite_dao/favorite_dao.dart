import 'dart:core';

import '../../data/vos/home_screen_api_vos/books_vo/books_vo.dart';

abstract class FavoriteDAO{
  void save( BooksVO favoriteBook,String listTitle);

  Stream watchFavoriteBooksBox();

  List<BooksVO>? getFavoriteBookListFromDataBase(String bookKey);

  Stream<List<BooksVO>?> getFavoriteBookListFromDataBaseStream(String bookKey);
}