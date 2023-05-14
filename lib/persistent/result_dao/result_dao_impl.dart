// import 'package:hive/hive.dart';
// import 'package:library_app/consts/api_consts.dart';
// import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';
// import 'package:library_app/persistent/result_dao/result_dao.dart';
//
// import '../../consts/persistent_const.dart';
//
// class ResultDAOImpl extends ResultsDAO{
//
//   ResultDAOImpl._();
//
//   static final ResultDAOImpl _singleton = ResultDAOImpl._();
//
//   factory ResultDAOImpl() => _singleton;
//
//   Box<ResultsVO> _getResultsBox() =>
//       Hive.box<ResultsVO>(kHiveBoxResultsName);
//
//
//   @override
//   ResultsVO? getResultsVOFromDatabase(String publishedDate) {
//    // print("#######################################3${_getResultsBox().get(publishedDate)}");
//    return _getResultsBox().get(publishedDate);
//   }
//
//   @override
//   Stream<ResultsVO?> getResultsVOFromDatabaseStream(String publishedDate) =>
//       Stream.value(getResultsVOFromDatabase(publishedDate));
//
//   @override
//   void save(ResultsVO resultsVO) {
//      _getResultsBox().put(resultsVO.publishedDate, resultsVO);
//    //  print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${_getResultsBox().values}");
//     // print("5555${resultsVO.publishedDate}");
//     // print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^${_getResultsBox().get(kPublishedDate)}");
//   }
//
//   @override
//   Stream watchResultsVOBox() =>_getResultsBox().watch();
//
//
// }