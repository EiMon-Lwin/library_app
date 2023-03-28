// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessInfo_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessInfoVO _$AccessInfoVOFromJson(Map<String, dynamic> json) => AccessInfoVO(
      country: json['country'] as String?,
      viewAbility: json['viewability'] as String?,
      embeddable: json['embeddable'] as bool?,
      publicDomain: json['publicDomain'] as bool?,
      textToSpeechPermission: json['textToSpeechPermission'] as String?,
      epub: json['epub'] == null
          ? null
          : EpubVO.fromJson(json['epub'] as Map<String, dynamic>),
      pdf: json['pdf'] == null
          ? null
          : EpubVO.fromJson(json['pdf'] as Map<String, dynamic>),
      webReaderLink: json['webReaderLink'] as String?,
      accessViewStatus: json['accessViewStatus'] as String?,
      quoteSharingAllowed: json['quoteSharingAllowed'] as bool?,
    );

Map<String, dynamic> _$AccessInfoVOToJson(AccessInfoVO instance) =>
    <String, dynamic>{
      'country': instance.country,
      'viewability': instance.viewAbility,
      'embeddable': instance.embeddable,
      'publicDomain': instance.publicDomain,
      'textToSpeechPermission': instance.textToSpeechPermission,
      'epub': instance.epub,
      'pdf': instance.pdf,
      'webReaderLink': instance.webReaderLink,
      'accessViewStatus': instance.accessViewStatus,
      'quoteSharingAllowed': instance.quoteSharingAllowed,
    };
