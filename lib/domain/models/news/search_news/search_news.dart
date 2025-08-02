import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/ui_model.dart';
import '../../../../data/models/api/news/search_news/search_news_api_dto.dart';
import '../../marketing_banner/marketing_banner.dart';

part 'search_news.freezed.dart';

@freezed
class SearchNewsData
    with _$SearchNewsData
    implements UIModel<SearchNewsDataApiDto> {
  const factory SearchNewsData({
    int? id,
    String? title,
    String? url,
    String? type,
    String? subtype,
    Embedded? eEmbedded,
  }) = _SearchNewsData;
  const SearchNewsData._();

  @override
  SearchNewsDataApiDto toApiDto() => const SearchNewsDataApiDto();
}

@freezed
class Embedded with _$Embedded implements UIModel<EmbeddedApiDto> {
  const factory Embedded({
    List<Self>? self,
  }) = _Embedded;
  const Embedded._();

  @override
  EmbeddedApiDto toApiDto() => const EmbeddedApiDto(
      //required field here
      );
}

@freezed
class Self with _$Self implements UIModel<SelfApiDto> {
  const factory Self({
    int? id,
    String? date,
    String? slug,
    String? type,
    String? link,
    Title? title,
    SearchAcf? acf,
  }) = _Self;
  const Self._();

  @override
  SelfApiDto toApiDto() => const SelfApiDto(
      //required field here
      );
}

@freezed
class SearchAcf with _$SearchAcf implements UIModel<SearchAcfApiDto> {
  const factory SearchAcf({
    int? featuredImage,
    String? description,
    String? shortDescription,
    String? category,
    String? publishedOn,
    dynamic sendToPushNotifications,
    String? includedSegments,
    String? pushNotificationHeading,
    String? pushNotificationContent,
  }) = _SearchAcf;
  const SearchAcf._();

  @override
  SearchAcfApiDto toApiDto() => const SearchAcfApiDto(
      //required field here
      );
}
