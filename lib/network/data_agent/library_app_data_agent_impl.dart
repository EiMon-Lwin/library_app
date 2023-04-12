import 'package:dio/dio.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/data/vos/search_api_vos/items_vo/items_vo.dart';
import 'package:library_app/network/api/home_screen_api/home_screen_api.dart';
import 'package:library_app/network/api/search_api/search_api.dart';
import 'package:library_app/network/data_agent/library_app_data_agent.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';

import '../../data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import '../../persistent/lists_dao/lists_dao.dart';

class LibraryAppDataAgentImpl extends LibraryAppDataAgent {
  late HomeScreenAPI _homeScreenAPI;

  late SearchAPI _searchAPI;

  LibraryAppDataAgentImpl._() {
    _homeScreenAPI = HomeScreenAPI(Dio());
    _searchAPI=SearchAPI(Dio());

  }

  static final LibraryAppDataAgentImpl _singleton = LibraryAppDataAgentImpl._();

  factory LibraryAppDataAgentImpl() => _singleton;




  @override
  Future<ResultsVO?> getResultsVO(String publishedDate) =>
      _homeScreenAPI.getHomeScreenApiResponse(kPublishedDate, kApiKey).asStream().map((event) {
        return  event.results;
      }).first;


  @override
  Future<List<ListsVO>?> getListsVO(String publishedDate) {
   return getResultsVO(publishedDate).then((value) {
    // var temp= value?.lists ?? [];
    // _listsDAO.save(temp);
    return value?.lists ?? [];
   }
   );
  }

  @override
  Future<List<ItemsVO>?> getItemsVO(String search) {
    return _searchAPI.getSearchResponse(search).
    asStream().map((event) => event.items).first;
  }



}