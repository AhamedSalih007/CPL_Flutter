import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/news/news.dart';
import '../teams/teams_api_dto.dart';

part 'news_api_dto.freezed.dart';
part 'news_api_dto.g.dart';

@freezed
class NewsDataApiDto with _$NewsDataApiDto implements ApiDto<NewsData> {
  const factory NewsDataApiDto({
    int? id,
    String? date,
    String? dateGmt,
    GuidApiDto? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    GuidApiDto? title,
    String? template,
    // dynamic meta,
    // dynamic categories,
    // dynamic tags,
    NewsApiDto? acf,
    //dynamic lLinks,
  }) = _NewsDataApiDto;
  const NewsDataApiDto._();

  factory NewsDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDataApiDtoFromJson(json);

  @override
  NewsData toModel() => NewsData(
        acf: acf?.toModel(),
        date: date,
        id: id,
        title: title?.toModel(),
      );
}

@freezed
class GuidApiDto with _$GuidApiDto implements ApiDto<Guid> {
  const factory GuidApiDto({
    String? rendered,
  }) = _GuidApiDto;
  const GuidApiDto._();

  factory GuidApiDto.fromJson(Map<String, dynamic> json) =>
      _$GuidApiDtoFromJson(json);

  @override
  Guid toModel() => Guid(rendered: rendered);
}

@freezed
class NewsApiDto with _$NewsApiDto implements ApiDto<NewsModel> {
  const factory NewsApiDto({
    @JsonKey(name: "featured_image") FeaturedImageApiDto? featuredImage,
    String? description,
    @JsonKey(name: "short_description") String? shortDescription,
    List<String>? category,
  }) = _NewsApiDto;
  const NewsApiDto._();

  factory NewsApiDto.fromJson(Map<String, dynamic> json) =>
      _$NewsApiDtoFromJson(json);

  @override
  NewsModel toModel() => NewsModel(
        featuredImage: featuredImage?.toModel(),
        description: description,
        shortDescription: shortDescription,
        category: category,
      );
}

@freezed
class FeaturedImageApiDto
    with _$FeaturedImageApiDto
    implements ApiDto<FeaturedImage> {
  const factory FeaturedImageApiDto({
    int? iD,
    int? id,
    String? title,
    String? filename,
    int? filesize,
    String? url,
    String? link,
    String? alt,
    String? author,
    String? description,
    String? caption,
    String? name,
    String? status,
    int? uploadedTo,
    String? date,
    String? modified,
    int? menuOrder,
    String? mimeType,
    String? type,
    String? subtype,
    String? icon,
    int? width,
    int? height,
    SizeApiDto? sizes,
  }) = _FeaturedImageApiDto;
  const FeaturedImageApiDto._();

  factory FeaturedImageApiDto.fromJson(Map<String, dynamic> json) =>
      _$FeaturedImageApiDtoFromJson(json);

  @override
  FeaturedImage toModel() =>
      FeaturedImage(id: id, url: url, sizes: sizes?.toModel());
}
