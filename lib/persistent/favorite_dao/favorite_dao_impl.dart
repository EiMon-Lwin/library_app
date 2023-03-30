import 'package:hive/hive.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/persistent/favorite_dao/favorite_dao.dart';

import '../../consts/persistent_const.dart';

class FavoriteDAOImpl extends FavoriteDAO {
  FavoriteDAOImpl._();

  static final FavoriteDAOImpl _singleton = FavoriteDAOImpl._();

  factory FavoriteDAOImpl() => _singleton;

  final Box<BooksVO> _getFavoriteBooksBox =
      Hive.box<BooksVO>(kFavoriteBooksListBoxName);

  Box<BooksVO> get getFavoriteBooksBox => _getFavoriteBooksBox;

  @override
  void save(BooksVO favoriteBook, String listTitle) {
    _getFavoriteBooksBox.put('$listTitle,${favoriteBook.title}', favoriteBook);
    print("Your Favorite Books are saved successfully in Hive------------------->${_getFavoriteBooksBox.values.toList()}");
  }

  @override
  List<BooksVO>? getFavoriteBookListFromDataBase(String bookKey) =>
    _getFavoriteBooksBox.values.toList();



  @override
  Stream<List<BooksVO>?> getFavoriteBookListFromDataBaseStream(String bookKey) =>
    Stream.value(getFavoriteBookListFromDataBase(bookKey));


  @override
  Stream watchFavoriteBooksBox() => _getFavoriteBooksBox.watch();
}
