import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

abstract class ListsDAO{

  void save(List<ListsVO> listOfLists);

  Stream watchListsBox();

  List<ListsVO>?  getListOfListsFromDataBase(String publishedDate);

  Stream<List<ListsVO>?> getListOfListsFromDataBaseStream(String publishedDate);
}