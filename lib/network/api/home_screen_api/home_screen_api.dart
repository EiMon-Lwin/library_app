
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../consts/api_consts.dart';
import '../../response/home_screen_api_response/home_screen_api_response.dart';

part 'home_screen_api.g.dart';
@RestApi(baseUrl: kBaseUrlForHomeScreen)
abstract class HomeScreenAPI{
  factory HomeScreenAPI(Dio dio)=>_HomeScreenAPI(dio);

///End Point
@GET(kEndPointForHomeScreen)
  Future<HomeScreenApiResponse> getHomeScreenApiResponse(
    @Query(kQueryParamsPublishedDate) String publishedDate,
    @Query(kQueryParamsApiKey) String apiKey,
    );


}