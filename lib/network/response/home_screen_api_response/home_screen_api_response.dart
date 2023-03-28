import 'package:json_annotation/json_annotation.dart';
import '../../../data/vos/home_screen_api_vos/results_vo/results_vo.dart';

part 'home_screen_api_response.g.dart';
@JsonSerializable()
class HomeScreenApiResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  ResultsVO? results;

  HomeScreenApiResponse(
      {this.status, this.copyright, this.numResults, this.results});

  factory HomeScreenApiResponse.fromJson(Map<String, dynamic> json) => _$HomeScreenApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeScreenApiResponseToJson(this);
}