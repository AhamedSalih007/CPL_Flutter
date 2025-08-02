import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/utils/mappers/api_dto.dart';
import '../../../../../domain/models/news/search_news/search_news.dart';
import '../../marketing_banner/marketing_banner_api_dto.dart';

part 'search_news_api_dto.freezed.dart';
part 'search_news_api_dto.g.dart';

@freezed
class SearchNewsDataApiDto
    with _$SearchNewsDataApiDto
    implements ApiDto<SearchNewsData> {
  const factory SearchNewsDataApiDto({
    int? id,
    String? title,
    String? url,
    String? type,
    String? subtype,
    @JsonKey(name: "_embedded") EmbeddedApiDto? eEmbedded,
  }) = _SearchNewsDataApiDto;
  const SearchNewsDataApiDto._();

  factory SearchNewsDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$SearchNewsDataApiDtoFromJson(json);

  @override
  SearchNewsData toModel() => SearchNewsData(
        id: id,
        title: title,
        url: url,
        type: type,
        subtype: subtype,
        eEmbedded: eEmbedded?.toModel(),
      );
}

@freezed
class EmbeddedApiDto with _$EmbeddedApiDto implements ApiDto<Embedded> {
  const factory EmbeddedApiDto({
    List<SelfApiDto>? self,
  }) = _EmbeddedApiDto;
  const EmbeddedApiDto._();

  factory EmbeddedApiDto.fromJson(Map<String, dynamic> json) =>
      _$EmbeddedApiDtoFromJson(json);

  @override
  Embedded toModel() => Embedded(self: self?.map((e) => e.toModel()).toList());
}

@freezed
class SelfApiDto with _$SelfApiDto implements ApiDto<Self> {
  const factory SelfApiDto({
    int? id,
    String? date,
    String? slug,
    String? type,
    String? link,
    TitleApiDto? title,
    SearchAcfApiDto? acf,
  }) = _SelfApiDto;
  const SelfApiDto._();

  factory SelfApiDto.fromJson(Map<String, dynamic> json) =>
      _$SelfApiDtoFromJson(json);

  @override
  Self toModel() => Self(
      id: id,
      date: date,
      slug: slug,
      type: type,
      link: link,
      title: title?.toModel(),
      acf: acf?.toModel());
}

@freezed
class SearchAcfApiDto with _$SearchAcfApiDto implements ApiDto<SearchAcf> {
  const factory SearchAcfApiDto({
    @JsonKey(name: "featured_image") int? featuredImage,
    String? description,
    @JsonKey(name: "short_description") String? shortDescription,
    String? category,
    @JsonKey(name: "published_on") String? publishedOn,
    @JsonKey(name: "send_to_push_notifications")
    dynamic sendToPushNotifications,
    @JsonKey(name: "included_segments") String? includedSegments,
    @JsonKey(name: "push_notidication_heading") String? pushNotificationHeading,
    @JsonKey(name: "push_notification_content") String? pushNotificationContent,
  }) = _SearchAcfApiDto;
  const SearchAcfApiDto._();

  factory SearchAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$SearchAcfApiDtoFromJson(json);

  @override
  SearchAcf toModel() => SearchAcf(
        featuredImage: featuredImage,
        description: description,
        shortDescription: shortDescription,
        category: category,
        sendToPushNotifications: sendToPushNotifications,
        includedSegments: includedSegments,
        publishedOn: publishedOn,
        pushNotificationContent: pushNotificationContent,
        pushNotificationHeading: pushNotificationHeading,
      );
}
