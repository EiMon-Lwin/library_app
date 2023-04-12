import 'package:flutter/cupertino.dart';

import '../data/apply/library_app_apply_impl.dart';
import '../data/vos/shelf_vos/shelf_vo.dart';

class ShowShelfBloc extends ChangeNotifier{

  /// state variable
  bool _isDispose = false;
  List<ShelfVO>? _shelfList;

  /// getter
  List<ShelfVO>? get getShelfList => _shelfList;

  /// state instance
  final LibraryAppApplyImpl _dataApply = LibraryAppApplyImpl();


  ShowShelfBloc(){
    _dataApply.getShelfVOFromDataBaseStream().listen((event) {
      _shelfList = event ?? [];
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if(!_isDispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }
}