import 'package:hive/hive.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/persistent/shelf_dao/shelf_dao.dart';

import '../../consts/persistent_const.dart';

class ShelfDAOImpl extends ShelfDAO{

  ShelfDAOImpl._();
  static final ShelfDAOImpl _singleton=ShelfDAOImpl._();
  factory ShelfDAOImpl() => _singleton;

  Box<ShelfVO> getShelfVOBox() => Hive.box<ShelfVO>(kBoxNameForListShelfVO);

  @override
  List<ShelfVO>? getListOfShelfVOFromDataBase() => getShelfVOBox().values.toList();

  @override
  Stream<List<ShelfVO>?> getListOfShelfVOFromDataBaseStream() =>Stream.value(getListOfShelfVOFromDataBase());

  @override
  void save(ShelfVO shelfVO){

      getShelfVOBox().put(shelfVO.shelfName.toString(), shelfVO);

  }




  @override
  Stream watchShelfBox() => getShelfVOBox().watch();

}