import 'package:json_annotation/json_annotation.dart';

part 'postModel.g.dart';

@JsonSerializable()
class PostModel {
  final int id;
  final String alt;
  final String photographer;
  final String url;

  PostModel({
    required this.id,
    required this.alt,
    required this.photographer,
    required this.url,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      alt: json['alt'],
      photographer: json['photographer'],
      url: json['src']['medium'],
    );
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class PhotoResponse {
  final List<PostModel> photos;

  PhotoResponse({required this.photos});

  factory PhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
