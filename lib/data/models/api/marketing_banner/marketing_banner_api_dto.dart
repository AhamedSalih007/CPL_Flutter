import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/marketing_banner/marketing_banner.dart';

part 'marketing_banner_api_dto.freezed.dart';
part 'marketing_banner_api_dto.g.dart';

@freezed
class MarketingBannerDataApiDto
    with _$MarketingBannerDataApiDto
    implements ApiDto<MarketingBannerData> {
  const factory MarketingBannerDataApiDto({
    @JsonKey(name: "id") final int? id,
    @JsonKey(name: "date") final String? date,
    @JsonKey(name: "date_gmt") final String? dateGmt,
    @JsonKey(name: "modified") final String? modified,
    @JsonKey(name: "modified_gmt") final String? modifiedGmt,
    @JsonKey(name: "link") final String? link,
    @JsonKey(name: "acf") final MarketingBannerAcfApiDto? acf,
  }) = _MarketingBannerDataApiDto;
  const MarketingBannerDataApiDto._();

  factory MarketingBannerDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarketingBannerDataApiDtoFromJson(json);

  @override
  MarketingBannerData toModel() => MarketingBannerData(
        id: id,
        date: date,
        dateGmt: dateGmt,
        modified: modified,
        modifiedGmt: modifiedGmt,
        link: link,
        acf: acf?.toModel(),
      );
}

@freezed
class TitleApiDto with _$TitleApiDto implements ApiDto<Title> {
  const factory TitleApiDto({
    @JsonKey(name: "rendered") final String? rendered,
  }) = _TitleApiDto;
  const TitleApiDto._();

  factory TitleApiDto.fromJson(Map<String, dynamic> json) =>
      _$TitleApiDtoFromJson(json);

  @override
  Title toModel() => Title(
        rendered: rendered,
      );
}

@freezed
class MarketingBannerAcfApiDto
    with _$MarketingBannerAcfApiDto
    implements ApiDto<MarketingBannerAcf> {
  const factory MarketingBannerAcfApiDto({
    @JsonKey(name: "marketing_banner")
    final List<MarketingBannerApiDto>? marketingBanner,
  }) = _MarketingBannerAcfApiDto;
  const MarketingBannerAcfApiDto._();

  factory MarketingBannerAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarketingBannerAcfApiDtoFromJson(json);

  @override
  MarketingBannerAcf toModel() => MarketingBannerAcf(
        marketingBanner: marketingBanner?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class MarketingBannerApiDto
    with _$MarketingBannerApiDto
    implements ApiDto<MarketingBanner> {
  const factory MarketingBannerApiDto({
    @JsonKey(name: "banner_image") final String? bannerImage,
    @JsonKey(name: "banner_1_hash") final String? banner1Hash,
    @JsonKey(name: "banner_title_1") final String? bannerTitle1,
    @JsonKey(name: "banner_title_2") final String? bannerTitle2,
    @JsonKey(name: "banner_description") final String? bannerDescription,
    @JsonKey(name: "button_text") final String? buttonText,
    @JsonKey(name: "button_url") final String? buttonUrl,
    @JsonKey(name: "banner_order") final String? bannerOrder,
  }) = _MarketingBannerApiDto;
  const MarketingBannerApiDto._();

  factory MarketingBannerApiDto.fromJson(Map<String, dynamic> json) =>
      _$MarketingBannerApiDtoFromJson(json);

  @override
  MarketingBanner toModel() => MarketingBanner(
        bannerImage: bannerImage,
        banner1Hash: banner1Hash,
        bannerTitle1: bannerTitle1,
        bannerTitle2: bannerTitle2,
        bannerDescription: bannerDescription,
        buttonText: buttonText,
        buttonUrl: buttonUrl,
        bannerOrder: bannerOrder,
      );
}
