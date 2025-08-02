import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/mappers/api_dto.dart';
import '../../../../domain/models/banner/banner.dart';
import '../teams/teams_api_dto.dart';

part 'banner_api_dto.freezed.dart';
part 'banner_api_dto.g.dart';

@freezed
class BannerAcfDataApiDto
    with _$BannerAcfDataApiDto
    implements ApiDto<BannerAcfData> {
  const factory BannerAcfDataApiDto({
    BannerAcfApiDto? acf,
  }) = _BannerAcfDataApiDto;
  const BannerAcfDataApiDto._();

  factory BannerAcfDataApiDto.fromJson(Map<String, dynamic> json) =>
      _$BannerAcfDataApiDtoFromJson(json);

  @override
  BannerAcfData toModel() => BannerAcfData(acf: acf?.toModel());
}

@freezed
class BannerAcfApiDto with _$BannerAcfApiDto implements ApiDto<BannerAcf> {
  const factory BannerAcfApiDto({
    @JsonKey(name: "teams_banner_image") BannerImageApiDto? teamsBannerImage,
    @JsonKey(name: "news_banner") BannerImageApiDto? newsBannerImage,
    @JsonKey(name: "matches_banner") BannerImageApiDto? matchesBannerImage,
  }) = _BannerAcfApiDto;
  const BannerAcfApiDto._();

  factory BannerAcfApiDto.fromJson(Map<String, dynamic> json) =>
      _$BannerAcfApiDtoFromJson(json);

  @override
  BannerAcf toModel() => BannerAcf(
        teamsBannerImage: teamsBannerImage?.toModel(),
        matchesBannerImage: matchesBannerImage?.toModel(),
        newsBannerImage: newsBannerImage?.toModel(),
      );
}

@freezed
class BannerImageApiDto
    with _$BannerImageApiDto
    implements ApiDto<BannerImage> {
  const factory BannerImageApiDto({
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
  }) = _BannerImageApiDto;
  const BannerImageApiDto._();

  factory BannerImageApiDto.fromJson(Map<String, dynamic> json) =>
      _$BannerImageApiDtoFromJson(json);

  @override
  BannerImage toModel() => BannerImage(url: url, sizes: sizes?.toModel());
}
