import '../../data/vos/shelf_vos/shelf_vo.dart';

abstract class ShelfDAO{
  void save(ShelfVO shelfVO);

  Stream watchShelfBox();

  List<ShelfVO>? getListOfShelfVOFromDataBase();

  Stream<List<ShelfVO>?> getListOfShelfVOFromDataBaseStream();
}