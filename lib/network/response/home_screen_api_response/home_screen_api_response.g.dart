// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenApiResponse _$HomeScreenApiResponseFromJson(
        Map<String, dynamic> json) =>
    HomeScreenApiResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: json['num_results'] as int?,
      results: json['results'] == null
          ? null
          : ResultsVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeScreenApiResponseToJson(
        HomeScreenApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
