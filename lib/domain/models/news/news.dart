import 'package:freezed_annotation/freezed_annotation.dart';
import '../teams/teams.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/news/news_api_dto.dart';

part 'news.freezed.dart';

@freezed
class NewsData with _$NewsData implements UIModel<NewsDataApiDto> {
  const factory NewsData({
    int? id,
    String? date,
    String? dateGmt,
    Guid? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    Guid? title,
    String? template,
    dynamic meta,
    dynamic categories,
    dynamic tags,
    NewsModel? acf,
    dynamic lLinks,
  }) = _NewsData;
  const NewsData._();

  @override
  NewsDataApiDto toApiDto() => const NewsDataApiDto(
      //required field here
      );
}

@freezed
class Guid with _$Guid implements UIModel<GuidApiDto> {
  const factory Guid({
    String? rendered,
  }) = _Guid;
  const Guid._();

  @override
  GuidApiDto toApiDto() => const GuidApiDto(
      //required field here
      );
}

@freezed
class NewsModel with _$NewsModel implements UIModel<NewsApiDto> {
  const factory NewsModel({
    FeaturedImage? featuredImage,
    String? description,
    String? shortDescription,
    List<String>? category,
  }) = _NewsModel;
  const NewsModel._();

  @override
  NewsApiDto toApiDto() => const NewsApiDto(
      //required field here
      );
}

class News {
  int id;
  String title;
  String? description;
  String imageUrl;
  String publishedOn;

  News(
      {required this.id,
      required this.title,
      this.description,
      required this.imageUrl,
      required this.publishedOn});
}

@freezed
class FeaturedImage
    with _$FeaturedImage
    implements UIModel<FeaturedImageApiDto> {
  const factory FeaturedImage({
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
    Size? sizes,
  }) = _FeaturedImage;
  const FeaturedImage._();

  @override
  FeaturedImageApiDto toApiDto() => const FeaturedImageApiDto(
      //required field here
      );
}
