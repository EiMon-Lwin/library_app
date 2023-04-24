import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../consts/api_consts.dart';
import '../../response/search_api_response/search_api_response.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: kSearchBaseUrl)
abstract class SearchAPI {
  factory SearchAPI(Dio dio) = _SearchAPI;

  @GET(kSearchEndPoint)
  Future<SearchAPIResponse> getSearchResponse(
    @Query(kQueryParamQ) String search,
  );
}
