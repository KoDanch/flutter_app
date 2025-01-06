// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: (json['id'] as num).toInt(),
      alt: json['alt'] as String,
      photographer: json['photographer'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'alt': instance.alt,
      'photographer': instance.photographer,
      'url': instance.url,
    };

PhotoResponse _$PostResponseFromJson(Map<String, dynamic> json) =>
    PhotoResponse(
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostResponseToJson(PhotoResponse instance) =>
    <String, dynamic>{
      'photos': instance.photos,
    };
