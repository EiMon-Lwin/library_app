import 'package:flutter/cupertino.dart';
import 'package:library_app/data/apply/library_app_apply_impl.dart';

import '../data/apply/library_app_apply.dart';
import '../data/vos/search_api_vos/items_vo/items_vo.dart';

class SearchPageBloc extends ChangeNotifier{

  /// State Variable
  List<ItemsVO>? _getItemVO=[];
  List<String>? _getSearchHistory=[];
  bool _isSearching=false;
  String _history='';
  TextEditingController _searchTextController=TextEditingController();

  /// Getter
 List<ItemsVO>? get getItemList => _getItemVO;
 List<String>? get getSearchHistory => _getSearchHistory;
 String get getHistory => _history;
 bool get getIsSearching => _isSearching;
 TextEditingController get getSearchEditigController => _searchTextController;

 ///State Instance
 final LibraryAppApply _libraryAppApply=LibraryAppApplyImpl();
 SearchPageBloc(){
   final list =_libraryAppApply.getSearchHistoryList();
   if(list == null){
     _getSearchHistory=null;
   }else if(list.isEmpty){
     _getSearchHistory=[];
   }else{
     _getSearchHistory=list;
   }
   notifyListeners();
 }

 void search(text){
   _isSearching=true;
   notifyListeners();
   _libraryAppApply.getItemListFromNetwork(text).then((value) {
     if(value !=null){
       _getItemVO=value;
       notifyListeners();
     }
   }).whenComplete(() {
     _isSearching=false;
     notifyListeners();
   });
 }

 void saveHistory(text){
   _libraryAppApply.saveSearchHistory(text);
 }

 void searchByHistory(text){
   _history=text;
   _searchTextController=TextEditingController(text: _history);
   search(text);
   notifyListeners();
 }

}