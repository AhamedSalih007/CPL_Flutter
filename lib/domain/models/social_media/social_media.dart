import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/mappers/ui_model.dart';
import '../../../data/models/api/social_media/social_media_api_dto.dart';
import '../news/news.dart';

part 'social_media.freezed.dart';

@freezed
class SocialMediaData
    with _$SocialMediaData
    implements UIModel<SocialMediaDataApiDto> {
  const factory SocialMediaData({
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
    int? author,
    int? featuredMedia,
    String? commentStatus,
    String? pingStatus,
    bool? sticky,
    String? template,
    String? format,
    SocialMediaAcf? acf,
  }) = _SocialMediaData;
  const SocialMediaData._();

  @override
  SocialMediaDataApiDto toApiDto() => const SocialMediaDataApiDto(
      //required field here
      );
}

@freezed
class SocialMediaAcf
    with _$SocialMediaAcf
    implements UIModel<SocialMediaAcfApiDto> {
  const factory SocialMediaAcf({
    List<SocialMedia>? socialMedia,
  }) = _SocialMediaAcf;
  const SocialMediaAcf._();

  @override
  SocialMediaAcfApiDto toApiDto() => const SocialMediaAcfApiDto(
      //required field here
      );
}

@freezed
class SocialMedia with _$SocialMedia implements UIModel<SocialMediaApiDto> {
  const factory SocialMedia({
    String? name,
    String? logo,
    String? url,
  }) = _SocialMedia;
  const SocialMedia._();

  @override
  SocialMediaApiDto toApiDto() => const SocialMediaApiDto(
      //required field here
      );
}
