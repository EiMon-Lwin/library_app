// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAPIResponse _$SearchAPIResponseFromJson(Map<String, dynamic> json) =>
    SearchAPIResponse(
      kind: json['kind'] as String?,
      totalItems: json['totalItems'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchAPIResponseToJson(SearchAPIResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
