import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/marketing_banner/marketing_banner_api_dto.dart';

part 'marketing_banner.freezed.dart';

@freezed
class MarketingBannerData
    with _$MarketingBannerData
    implements UIModel<MarketingBannerDataApiDto> {
  const factory MarketingBannerData({
    final int? id,
    final String? date,
    final String? dateGmt,
    final String? modified,
    final String? modifiedGmt,
    final String? link,
    final MarketingBannerAcf? acf,
  }) = _MarketingBannerData;
  const MarketingBannerData._();

  @override
  MarketingBannerDataApiDto toApiDto() => MarketingBannerDataApiDto(
        id: id,
        date: date,
        dateGmt: dateGmt,
        modified: modified,
        modifiedGmt: modifiedGmt,
        link: link,
        acf: acf?.toApiDto(),
      );
}

@freezed
class Title with _$Title implements UIModel<TitleApiDto> {
  const factory Title({
    final String? rendered,
  }) = _Title;
  const Title._();

  @override
  TitleApiDto toApiDto() => TitleApiDto(
        rendered: rendered,
      );
}

@freezed
class MarketingBannerAcf
    with _$MarketingBannerAcf
    implements UIModel<MarketingBannerAcfApiDto> {
  const factory MarketingBannerAcf({
    final List<MarketingBanner>? marketingBanner,
  }) = _MarketingBannerAcf;
  const MarketingBannerAcf._();

  @override
  MarketingBannerAcfApiDto toApiDto() => MarketingBannerAcfApiDto(
        marketingBanner: marketingBanner?.map((e) => e.toApiDto()).toList(),
      );
}

@freezed
class MarketingBanner
    with _$MarketingBanner
    implements UIModel<MarketingBannerApiDto> {
  const factory MarketingBanner({
    final String? bannerImage,
    final String? banner1Hash,
    final String? bannerTitle1,
    final String? bannerTitle2,
    final String? bannerDescription,
    final String? buttonText,
    final String? buttonUrl,
    final String? bannerOrder,
  }) = _MarketingBanner;
  const MarketingBanner._();

  @override
  MarketingBannerApiDto toApiDto() => MarketingBannerApiDto(
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
