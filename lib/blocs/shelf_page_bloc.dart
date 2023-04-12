import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';

import '../data/apply/library_app_apply_impl.dart';
import '../data/vos/shelf_vos/shelf_vo.dart';
import '../persistent/shelf_dao/shelf_dao_impl.dart';

class ShelfPageBloc extends ChangeNotifier{
  bool _dispose=false;

  List<ShelfVO> _shelfList=[];
  var keys=[];


  ///Getter
 bool get isDispose=>_dispose;

 List<ShelfVO> get getShelfList=>_shelfList;
 GlobalKey<FormState> get getGlobalKey => _formKey;
 TextEditingController get getTextEditingController=> _controller;



 ///Create Instance
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _controller=TextEditingController();
  final ShelfDAOImpl _shelfDaoImpl=ShelfDAOImpl();
  final LibraryAppApplyImpl _libraryAppApply=LibraryAppApplyImpl();

  ShelfPageBloc() {
      _libraryAppApply.getShelfVOFromDataBaseStream().listen((event) {
        _shelfList=event ?? [];
        notifyListeners();

      });



  }

  void saveNewShelfVOList(){
     var shelfName=_controller.text.toString();
     // var shelfVO=ShelfVO(shelfName, []);
     // _shelfList.add(shelfVO);
     // _shelfDaoImpl.save(_shelfList);
    _libraryAppApply.createShelf(shelfName, []);
    notifyListeners();

  }

void addBookToShelf(ShelfVO shelfVO,BooksVO booksVO) {

   shelfVO.shelfBooks?.add(booksVO);
   _shelfDaoImpl.save(shelfVO);

  notifyListeners();


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