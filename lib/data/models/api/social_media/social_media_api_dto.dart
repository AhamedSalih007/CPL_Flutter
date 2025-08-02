import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/social_media/social_media.dart';
import '../news/news_api_dto.dart';

part 'social_media_api_dto.freezed.dart';
part 'social_media_api_dto.g.dart';

@freezed
class SocialMediaDataApiDto
    with _$SocialMediaDataApiDto
    implements ApiDto<SocialMediaData> {
  const factory SocialMediaDataApiDto({
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
    // Content? content,
    // Content? excerpt,
    int? author,
    int? featuredMedia,
    String? commentStatus,
    String? pingStatus,
    bool? sticky,
    String? template,
    String? format,
    //Meta? meta,
    //List<int>? categories,
    //List<Null>? tags,
    SocialMediaAcfApiDto? acf,
    //Links? lLinks,
  }) = _SocialMediaDataApiDto;
  const SocialMediaDataApiDto._();

  factory SocialMediaDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaDataApiDtoFromJson(json);

  @override
  SocialMediaData toModel() => SocialMediaData(
        id: id,
        slug: slug,
        acf: acf?.toModel(),
      );
}

@freezed
class SocialMediaAcfApiDto
    with _$SocialMediaAcfApiDto
    implements ApiDto<SocialMediaAcf> {
  const factory SocialMediaAcfApiDto({
    @JsonKey(name: "social_media") List<SocialMediaApiDto>? socialMedia,
  }) = _SocialMediaAcfApiDto;
  const SocialMediaAcfApiDto._();

  factory SocialMediaAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaAcfApiDtoFromJson(json);

  @override
  SocialMediaAcf toModel() => SocialMediaAcf(
      socialMedia: socialMedia?.map((e) => e.toModel()).toList());
}

@freezed
class SocialMediaApiDto
    with _$SocialMediaApiDto
    implements ApiDto<SocialMedia> {
  const factory SocialMediaApiDto({
    String? name,
    String? logo,
    String? url,
  }) = _SocialMediaApiDto;
  const SocialMediaApiDto._();

  factory SocialMediaApiDto.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaApiDtoFromJson(json);

  @override
  SocialMedia toModel() => SocialMedia(
        logo: logo,
        name: name,
        url: url,
      );
}
